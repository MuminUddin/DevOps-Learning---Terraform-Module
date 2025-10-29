# DevOps-Learning---Terraform-Module  

## Terraform Modular WordPress Deployment on AWS  
* This project uses Terraform to deploy a modular and automated WordPress environment on AWS.
* It follows Infrastructure as Code principles and demonstrates how to structure Terraform configurations into reusable modules.

## Here is the file structure:  

```
.
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── ec2/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── .gitignore
└── README.md
```
## Overview
This Terraform project provisions a modular WordPress setup on AWS using three separate modules:
* VPC Module: Creates a custom VPC, subnet, route table, and internet gateway
* Security Module: Defines ingress and egress rules for HTTP, HTTPS, and SSH
* EC2 Module: Launches an Ubuntu EC2 instance that automatically installs Apache, PHP, and WordPress using user_data

Each module is reusable and designed to be referenced from the root module (main.tf).

## Key Learnings
* How to break down Terraform configurations into reusable modules
* How to use outputs and variables to link modules together
* Understanding dependencies between network, security, and compute layers
* Using user_data for automated WordPress installation and configuration
