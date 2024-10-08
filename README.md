EC2 Instance Provisioning with Terraform

Overview

This repository contains Terraform configurations for provisioning an EC2 instance on Amazon Web Services (AWS). The setup is designed to automate the deployment of infrastructure, ensuring that your cloud resources are managed efficiently and consistently.


Features

Automated EC2 Instance Creation: Easily spin up EC2 instances with predefined configurations.
Customizable Instance Types: Modify the instance type, AMI, and other parameters to fit your needs.
VPC and Security Group Setup: Automatically configures VPCs and security groups for network management and security.
Key Pair Management: Includes options to specify or generate SSH key pairs for secure access.

Prerequisites

Terraform: Ensure you have Terraform installed on your local machine. Terraform Installation Guide

AWS CLI: Set up the AWS Command Line Interface (CLI) with your credentials. AWS CLI Installation Guide

Getting Started

1. Clone the Repository:
  
   git clone https://github.com/whizdome/ec2-instance-terraform.git
   
   cd ec2-instance-terraform

2. Initialize Terraform

	 terraform init

3. Customize Variables:
   Modify the variables.tf file to adjust the instance type, region, and other parameters.

4. Apply the Configuration:

	 terraform apply

Review the plan and type yes to execute.

Repository Structure

main.tf: Main Terraform configuration file for the EC2 instance.

variables.tf: Defines input variables to customize the deployment.

outputs.tf: Specifies the outputs, such as the instance ID and public IP.

user_data.tpl: Template for provisioning scripts executed on instance startup.




Cleaning Up

To destroy the resources created by Terraform, run:

terraform destroy

Contributing

Feel free to submit issues or pull requests if you have suggestions for improving this project.
