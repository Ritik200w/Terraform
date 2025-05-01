# 🚀 AWS EKS Cluster Setup using Terraform

Hey there! 👋  
This project uses **Terraform** to create a **Kubernetes (EKS)** cluster on **AWS** along with all the necessary infrastructure like:

- VPC (Virtual Private Cloud)
- Subnets (public & private)
- Security Groups
- IAM roles
- EKS Cluster + Node Group

I'm learning DevOps and cloud technologies, and this is part of my hands-on practice. If you're a beginner too, this repo can help you get started!

---

## 📁 What's Inside

Here’s a quick explanation of each Terraform file:

| File Name      | Purpose                                                  |
|----------------|----------------------------------------------------------|
| `provider.tf`  | Connects Terraform to AWS                                |
| `vpc.tf`       | Creates a custom network with subnets, NAT, and routes   |
| `sg.tf`        | Creates security groups for EKS and EC2 communication    |
| `eks.tf`       | Provisions the EKS cluster and worker nodes              |
| `variable.tf`  | Stores input values (like region, instance type, etc.)   |

---

## 🛠️ How to Use This Project

> ✅ Prerequisites:
> - AWS account
> - AWS CLI configured (`aws configure`)
> - Terraform installed
> - Basic understanding of CLI

### 1. Clone the Repository
git clone https://github.com/Ritik200w/Terraform.git
cd Terraform

2. Initialize Terraform

terraform init

3. Preview the Changes

terraform plan

4. Apply and Create the Infrastructure

terraform apply

(Type yes when asked to confirm)
5. Access Your EKS Cluster

After creation, you can connect to the EKS cluster using:

aws eks update-kubeconfig --region <your-region> --name <cluster-name>
kubectl get nodes

6. Clean Up (Destroy Everything)

terraform destroy
