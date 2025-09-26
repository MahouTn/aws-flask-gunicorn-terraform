# 🚀 Robust Flask Deployment on AWS EC2 with Terraform Provisioners

## 🚀 Overview
This project demonstrates a production-ready approach to deploying a Python Flask web application onto an Amazon EC2 instance using Terraform Provisioners. It focuses on solving real-world DevOps challenges, specifically ensuring the application runs continuously in the background using the Gunicorn WSGI server on the standard HTTP Port 80.

### 🏗️ Architecture

![S3](https://imgur.com/VM8jnIo)
The project's architecture involves two main stages managed by Terraform:

Infrastructure: Terraform provisions a VPC, Subnet, Security Group (opening Ports 22 and 80), and the EC2 instance itself.

Deployment (Provisioning): The remote-exec provisioner connects via SSH, installs Python/pip/venv, installs Flask and Gunicorn, and executes the final command to launch the Gunicorn server on Port 80 as a detached root process.

### 🛠️ Technologies Used
Terraform: For provisioning all AWS resources (Infrastructure as Code).

* AWS EC2: The target compute resource for hosting the application.
* Python/Flask: The application framework.
* Gunicorn: The high-performance, production-ready Web Server Gateway Interface (WSGI) server.
* remote-exec Provisioner: The core automation tool used to bootstrap the server.

### 📋 Prerequisites
Before deploying this project, ensure you have the following installed and configured:

1. AWS Account: An active AWS account is required.
2. AWS CLI: Configured with valid credentials to allow Terraform to authenticate.
3. Terraform CLI: Installed and ready to execute commands.
4. Application Files: The app.py and templates/index.html files must be present in your project structure.
5. SSH Key: A public SSH key configured on your machine (~/.ssh/id_ed25519.pub) and referenced in the Terraform configuration (key_pair.tf).

### 🚀 Deployment
Follow these steps to deploy the static website:

1. Clone the Repository:
```
-> git clone [https://github.com/MahouTn/aws-flask-gunicorn-terraform.git](https://github.com/MahouTn/aws-flask-gunicorn-terraform.git)
-> cd aws-flask-gunicorn-terraform
```


2. Initialize Terraform:
This command downloads the necessary AWS provider plugins.
```
-> terraform init
```



3. Apply the Configuration:
This command will create all the AWS resources defined in the configuration files.

```
-> terraform apply
```


4. Get the Website URL:
After a successful terraform apply, the output will provide the public URL of your new website.
```
-> terraform output "public_ip"
```

![S3](https://imgur.com/igA6kpy)

5. Verify the Application in the Browser
Navigate to the Public IP in your web browser to confirm the application is serving the index.html content on Port 80.

![S3](https://imgur.com/rI7S8IP)

### 🧹 Cleanup
To avoid incurring any costs, you can destroy all the created resources with a single command.
```
-> terraform destroy
```


This will safely terminate the EC2 instance and remove all network infrastructure.
