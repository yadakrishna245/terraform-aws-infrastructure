<div align="center">

# 🏗️ Terraform AWS Infrastructure

### Production-Ready Multi-Tier AWS Infrastructure as Code

[![Terraform](https://img.shields.io/badge/Terraform-v1.5+-623CE4?logo=terraform&logoColor=white)](https://terraform.io)
[![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazon-aws&logoColor=white)](https://aws.amazon.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

</div>

---

## 📌 Overview

End-to-end AWS infrastructure provisioned with **Terraform**, demonstrating modular IaC practices including VPC networking, compute, managed databases, CDN delivery, and IAM security — all following AWS Well-Architected Framework principles.

## 🏛️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        AWS Cloud                             │
│                                                             │
│  ┌──────────────┐     ┌──────────────────────────────────┐ │
│  │  CloudFront  │────▶│  S3 Bucket (Private + OAC)       │ │
│  │  (CDN/HTTPS) │     └──────────────────────────────────┘ │
│  └──────────────┘                                           │
│                                                             │
│  ┌────────────────────── VPC (10.0.0.0/16) ──────────────┐ │
│  │                                                        │ │
│  │  ┌─ Public Subnets ──────────────────────────────┐    │ │
│  │  │  10.0.1.0/24  │  10.0.2.0/24                  │    │ │
│  │  │  ┌──────────┐                                 │    │ │
│  │  │  │   EC2    │ ◀── Security Group (Dynamic)    │    │ │
│  │  │  │ t3.micro │     Ports: 22, 80, 443          │    │ │
│  │  │  └──────────┘                                 │    │ │
│  │  └───────────────────────────────────────────────┘    │ │
│  │                                                        │ │
│  │  ┌─ Private Subnets ─────────────────────────────┐    │ │
│  │  │  10.0.10.0/24  │  10.0.20.0/24                │    │ │
│  │  │  ┌──────────┐                                 │    │ │
│  │  │  │   RDS    │ ◀── Backup: 2 days retention    │    │ │
│  │  │  │  MySQL   │     Deletion Protection: ON     │    │ │
│  │  │  └──────────┘                                 │    │ │
│  │  └───────────────────────────────────────────────┘    │ │
│  └────────────────────────────────────────────────────────┘ │
│                                                             │
│  ┌──────────────┐                                           │
│  │  IAM User    │──── AmazonS3FullAccess (Managed Policy)  │
│  └──────────────┘                                           │
└─────────────────────────────────────────────────────────────┘
```

## 📂 Project Structure

```
terraform-aws-infrastructure/
├── main.tf                    # Root module - orchestrates all modules
├── provider.tf                # AWS provider configuration
├── variables.tf               # Input variables
├── outputs.tf                 # Root outputs
├── .gitignore
├── modules/
│   ├── s3-cloudfront/         # Private S3 + CloudFront CDN with OAC
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vpc-ec2/               # VPC + Dynamic SG + EC2
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── rds/                   # RDS MySQL + Snapshots + Protection
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── iam/                   # IAM User + Policy Attachment
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```

## 🚀 Modules

| Module | Resources | Key Features |
|--------|-----------|--------------|
| **s3-cloudfront** | S3, CloudFront, OAC, Bucket Policy | Private bucket, HTTPS-only CDN, Origin Access Control |
| **vpc-ec2** | VPC, Subnets, SG, EC2 | Terraform Registry module, Dynamic Block for SG rules |
| **rds** | RDS MySQL, Subnet Group, SG | 2-day backup retention, Deletion protection |
| **iam** | IAM User, Policy Attachment | Managed policy (AmazonS3FullAccess) |

## ⚡ Quick Start

### Prerequisites

- Terraform >= 1.5
- AWS CLI configured (`aws configure`)
- AWS Account with appropriate permissions

### Deploy

```bash
# Clone
git clone https://github.com/yadakrishna245/terraform-aws-infrastructure.git
cd terraform-aws-infrastructure

# Initialize
terraform init

# Preview
terraform plan

# Deploy
terraform apply
```

### Destroy

```bash
# Disable RDS deletion protection first (edit modules/rds/main.tf)
# Change: deletion_protection = false
terraform apply

# Then destroy
terraform destroy
```

## 🔑 Key Terraform Features Demonstrated

| Feature | Where Used |
|---------|-----------|
| **Modules** | All resources organized in reusable modules |
| **Dynamic Blocks** | Security Group ingress rules (vpc-ec2 module) |
| **Registry Modules** | VPC created using `terraform-aws-modules/vpc/aws` |
| **Variables & Outputs** | Parameterized configuration across all modules |
| **Data Sources** | AMI lookup for latest Amazon Linux 2023 |
| **Sensitive Variables** | RDS password marked as sensitive |
| **Resource Dependencies** | Cross-module references (VPC → RDS, SG → EC2) |

## 🛡️ Security Best Practices

- ✅ S3 bucket fully private (all public access blocked)
- ✅ CloudFront OAC (no legacy OAI)
- ✅ RDS in private subnets (no public access)
- ✅ RDS deletion protection enabled
- ✅ Security group least-privilege (only required ports)
- ✅ Sensitive variables for passwords
- ✅ State file excluded from version control

## 📊 Outputs

| Output | Description |
|--------|-------------|
| `cloudfront_url` | CloudFront distribution URL |
| `s3_bucket_name` | S3 bucket name |
| `vpc_id` | VPC identifier |
| `ec2_public_ip` | EC2 public IP address |
| `rds_endpoint` | RDS connection endpoint |
| `iam_user_arn` | IAM user ARN |

## 👤 Author

**Yada Krishna Chaithanya**
- Senior Linux Administrator | Cloud & Security Operations
- Gemini Solutions Pvt Ltd, Bangalore
- GitHub: [@yadakrishna245](https://github.com/yadakrishna245)

---

<div align="center">

*Built with Terraform • Deployed on AWS • June 2026*

</div>
