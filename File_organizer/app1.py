from flask import Flask, request, render_template, jsonify
import boto3
import json
import time
import threading
from botocore.exceptions import ClientError

app = Flask(__name__)

REGION = "ap-south-1"
s3 = boto3.client('s3', region_name=REGION)
sqs = boto3.client('sqs', region_name=REGION)
secrets_manager = boto3.client('secretsmanager', region_name=REGION)


def get_secrets(secret_name):
    try:
        response = secrets_manager.get_secret_value(SecretId=secret_name)
        return json.loads(response['SecretString'])
    except ClientError as e:
        print(f"Error retrieving secrets: {e}")
        return None

# Configuring the secrets and its respective settings for it to retrieve those values form the secrets manager
secrets = get_secrets('arn:aws:secretsmanager:ap-south-1:011528296400:secret:file-organizer-app-secrets-mCCpTp') 
if not secrets:
    print("Failed to load secrets. Exiting...")
    exit(1)

incoming_queue_url = secrets['incoming_queue_url']
completion_queue_url = secrets['completion_queue_url']
s3_bucket = secrets['s3_bucket']

file_folders = {
    'image': 'images/',
    'document': 'documents/',
    'video': 'videos/',
    'other': 'others/'
}

@app.route('/')
def index():
    return render_template('upload.html')

@app.route('/upload', methods=['POST'])
def upload_file():
    file = request.files['file']
    file_type = request.form.get('file_type', 'other')
    s3_key = f"uploads/{file.filename}"

    # It helps uploads the file to S3
    s3.upload_fileobj(file, s3_bucket, s3_key)
    print(f"Uploaded {file.filename} to S3 bucket {s3_bucket}")

    # Sending message to aws sqs to the incoming queue url that some file has came in S3
    message = {'s3_key': s3_key, 'file_type': file_type}
    sqs.send_message(QueueUrl=incoming_queue_url, MessageBody=json.dumps(message))
    print(f"Sent message to SQS for {file.filename}")

    return jsonify({'status': 'File uploaded successfully!'})

def poll_sqs():
    try:
        response = sqs.receive_message(QueueUrl=incoming_queue_url, MaxNumberOfMessages=1, WaitTimeSeconds=5)
        messages = response.get('Messages', [])
        for message in messages:
            msg_body = json.loads(message['Body'])
            process_file(msg_body)
            sqs.delete_message(QueueUrl=incoming_queue_url, ReceiptHandle=message['ReceiptHandle'])
    except ClientError as e:
        print(f"Error polling SQS: {e}")

def process_file(msg_body):
    try:
        s3_key = msg_body['s3_key']
        file_type = msg_body.get('file_type', 'other')
        destination_folder = file_folders.get(file_type, file_folders['other'])
        destination_key = f"{destination_folder}{s3_key.split('/')[-1]}"

        s3.copy_object(Bucket=s3_bucket, CopySource={'Bucket': s3_bucket, 'Key': s3_key}, Key=destination_key)
        s3.delete_object(Bucket=s3_bucket, Key=s3_key)
        
        print(f"File {s3_key} organized into {destination_key}")
        send_completion_notification(destination_key)
    
    except ClientError as e:
        print(f"Error processing file {msg_body['s3_key']}: {e}")

def send_completion_notification(file_path):
    try:
        completion_message = {'file': file_path, 'status': 'organized'}
        sqs.send_message(QueueUrl=completion_queue_url, MessageBody=json.dumps(completion_message))
        print(f"Sent completion notification for {file_path}")
    except ClientError as e:
        print(f"Error sending completion notification: {e}")

def start_backend():
    print("Starting S3 File Organizer Backend...")
    while True:
        poll_sqs()
        time.sleep(2)

if __name__ == "__main__":
    # Here, the flask app is created in a separate thread before the start of the backend processing begins
    flask_thread = threading.Thread(target=app.run, kwargs={'host': '0.0.0.0', 'port': 5000})
    flask_thread.daemon = True
    flask_thread.start()

    # Starts the backend polling which eventually keeps the backed running for polling any new messages in the queue in order to process it to the S3 subfolder.
    start_backend()
