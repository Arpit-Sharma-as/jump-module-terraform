# 🚀 GKE Private Cluster with VPN Access — Terraform Modular Setup

This project provisions a **Private Google Kubernetes Engine (GKE) Cluster** on GCP with **Cloud VPN access**, using a **modular Terraform structure**.  
It follows infrastructure-as-code (IaC) best practices for scalability, security, and reusability.

---

## 📁 Directory Structure

```
module_terra/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
├── .gitignore
├── modules/
│   ├── VPN/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── enable_apis/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── gke/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── network/
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
```

---

## 🧱 Modules Overview

| Module Name               | Purpose                                        |
|---------------------------|------------------------------------------------|
| `enable_apis`             | Enables required GCP APIs                      |
| `network`                 | Creates custom VPC, subnets, firewall rules   |
| `VPN`                     | Sets up Cloud VPN gateway, tunnel, routing    |
| `gke`                     | Deploys private GKE cluster                   |
| Root `main.tf`            | Integrates all modules                        |
| `terraform.tfvars.example` | Example file with required variables         |

---

## 🔧 Prerequisites

- ✅ GCP project with billing enabled
- ✅ Terraform CLI v1.3+
- ✅ gcloud CLI installed and authenticated
- ✅ Service account with roles:
  - Compute Admin  
  - Kubernetes Engine Admin  
  - Service Account User  
  - Network Admin  
- ✅ Enable these APIs:
  - `compute.googleapis.com`  
  - `container.googleapis.com`  
  - `servicenetworking.googleapis.com`  
  - `cloudvpn.googleapis.com`

---

## 🚀 Usage Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/<your-username>/module_terra.git
cd module_terra
```

---

### 2. Create `terraform.tfvars`

Create a file called `terraform.tfvars` and fill with your actual values:

```hcl
project_id                  = "your-gcp-project-id"
region                      = "us-central1"
network_name                = "custom-vpc"
subnet_cidr                 = "10.0.0.0/16"
secondary_range_pods        = "10.1.0.0/16"
secondary_range_services    = "10.2.0.0/20"
gke_cluster_name            = "private-gke-cluster"
vpn_gateway_name            = "gke-cloud-vpn"
shared_secret               = "vpn-shared-secret"
on_prem_gateway_ip          = "your-home-or-office-gateway-public-ip"
```

---

### 3. Initialize Terraform

```bash
terraform init
```

---

### 4. Review the Plan

```bash
terraform plan -var-file="terraform.tfvars"
```

---

### 5. Apply to Deploy Infrastructure

```bash
terraform apply -var-file="terraform.tfvars"
```

---

### 6. Destroy to Clean Up

```bash
terraform destroy -var-file="terraform.tfvars"
```

---

## 🛡️ Security Best Practices

- ❌ **Never** commit:
  - `terraform.tfvars`
  - `terraform.tfstate*`
  - `.terraform/`
- ✅ Always use `.gitignore`
- ✅ Use GCS remote state + locking for team setups
- ✅ Use secrets manager for credentials

---

## 📄 Sample `.gitignore`

```gitignore
# Terraform state and cache
.terraform/
terraform.tfstate
terraform.tfstate.backup

# Sensitive variables
terraform.tfvars

# Logs
crash.log
*.log
```

---

## 📄 Sample `terraform.tfvars.example`

```hcl
project_id                  = "sample-project-id"
region                      = "us-central1"
network_name                = "custom-vpc"
subnet_cidr                 = "10.0.0.0/16"
secondary_range_pods        = "10.1.0.0/16"
secondary_range_services    = "10.2.0.0/20"
gke_cluster_name            = "private-gke-cluster"
vpn_gateway_name            = "gke-cloud-vpn"
shared_secret               = "vpn-shared-key"
on_prem_gateway_ip          = "192.168.1.1"
```

---

## 🧠 Best Practices

- Use modular structure for scalability and reusability
- Use `terraform fmt` and `terraform validate` regularly
- Separate environments with folders or workspaces (e.g., `dev`, `uat`, `prod`)
- Protect sensitive values using Vault or Secret Manager
- Use version pinning for Terraform provider versions

---

## 🙋 Author

**Arpit Sharma**  
DevOps & Cloud Engineer  
📫 Contact: [GitHub](https://github.com/Arpit-Sharma-as)

---

## 📜 License

This project is licensed under the **MIT License** — free to use, modify, and distribute with credit.
