# file_organizer
This repository contains Terraform configuration for deploying AWS infrastructure to support a Python-based application. The setup leverages S3, SQS, and Secrets Manager for file management and secure operations.

Directory Structure
main.tf: Main Terraform configuration.
variables.tf: Input variables for customization.
outputs.tf: Output values from the Terraform deployment.
modules/: Reusable Terraform modules for specific resources.
Prerequisites
Install Terraform.
Configure AWS CLI with proper credentials.
Ensure you have an EC2 key pair for SSH access.
Instructions
1. Initialize Terraform
Run the following command in the root directory of the repository to initialize Terraform:
terraform init  
2. Plan the Deployment
Generate an execution plan to verify changes:
terraform plan  
3. Apply the Configuration
Deploy the infrastructure using:
terraform apply  
4. Transfer Files to EC2
SSH into the EC2 instance using PuTTY or any SSH client with your key pair.
Transfer your application files to the EC2 instance using SCP or PuTTY file transfer.
5. Set Up the EC2 Instance
After transferring files, configure the instance:

Install required dependencies:
sudo dnf install python3 python3-pip -y  
pip3 install flask boto3  
Run the Python application:

python3 file_name.py  
6. Access the Application
Open the EC2 instance's public IP in your browser at port 5000:

http://<ec2-private-ip>:5000  
7. File Management in the Application
Upload files via the UI.
The application processes the files and stores them in specific S3 bucket folders based on file type.
The workflow uses SQS for message queuing and Secrets Manager for secure credential handling.
