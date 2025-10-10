# 🔐 Azure Multi-Tier Network with Private SQL Integration

This project provisions a secure, multi-tier Azure infrastructure using Terraform. It includes isolated subnets for frontend, backend, database, and Bastion access, with a managed Azure SQL Server connected via Private Endpoint and DNS zone integration.

---

## 🧱 Infrastructure Overview

### 🔹 Virtual Network

- **Name**: `VirtualNetwork`
- **Address Space**: `10.0.0.0/16`
- **Location**: `${var.location}`

### 🔹 Subnet Layout

| Subnet Name         | Address Prefix   | Purpose                                |
|---------------------|------------------|----------------------------------------|
| `subnet-frontend`   | `10.0.1.0/24`     | Hosts frontend VM                      |
| `subnet-backend`    | `10.0.2.0/24`     | Hosts backend VM (Bastion-accessible) |
| `subnet-db`         | `10.0.3.0/24`     | Hosts Azure SQL Private Endpoint       |
| `AzureBastionSubnet`| `10.0.4.0/24`     | Dedicated subnet for Bastion host      |

---

## 🖥️ Virtual Machines

### 🔹 Frontend VM

- Deployed in `subnet-frontend`
- SSH accessible via public IP or Bastion
- Intended to host web app or API
- Can connect to backend or SQL tier

### 🔹 Backend VM

- Deployed in `subnet-backend`
- SSH access via Azure Bastion
- Connects securely to Azure SQL via Private Endpoint
- Used for internal logic and database queries

---

## 🗄️ Azure SQL Integration

### ✅ Provisioned Resources

- **SQL Server**: `sql-server-lewis-test`
- **SQL Database**: `sqldb`
- **Private Endpoint**: Deployed in `subnet-db`
- **Private DNS Zone**: `privatelink.database.windows.net`
- **DNS Zone Group**: Attached to Private Endpoint
- **VNet Link**: DNS zone linked to backend VNet

### 🔒 Security

- No public access to SQL Server
- NSG rules restrict traffic to port 1433 from backend subnet only
- DNS resolution scoped to VNet via Private DNS Zone

---

## 🧪 Connectivity Validation

### 🔹 DNS Resolution

bash
nslookup sql-server-lewis-test.database.windows.net


## 🔐 Bastion Access
Bastion host deployed in AzureBastionSubnet

Used for secure SSH access to backend VM

No public IPs exposed on backend resources

## 📦 Terraform Modules
Modular structure for VNet, NSGs, SQL, Private Endpoint, and DNS

Explicit resource wiring for traceability and hygiene

Variables used for location, resource group, subnet IDs, and credentials

## 🔐 Azure Key Vault Integration
This project includes a secure, RBAC-based Azure Key Vault setup designed for scalable secret management and enterprise-grade access control.

### ✅ Features
Terraform-provisioned Key Vault with soft delete and purge protection

RBAC access model (no classic access policies)

Azure AD group created via Terraform for centralized access

Current user added to the group automatically

Group assigned Key Vault Secrets User role via azurerm_role_assignment

SSH private key uploaded manually via Azure CLI for secure testing

### 🔧 Manual Secret Upload (Example)
bash
az keyvault secret set --vault-name kv-lewis-secure --name ssh-private-key --file ~/.ssh/id_rsa

### 📁 Terraform Highlights
hcl
resource "azuread_group" "kv_access_group" { ... }

resource "azuread_group_member" "lewis_in_group" { ... }

resource "azurerm_role_assignment" "kv_group_access" { ... }

resource "azurerm_key_vault" "kv" { ... }
### 🧠 Access Model
Access is granted via Azure Entra ID using RBAC. No passwords or access policies are used. Only members of the provisioned group can access secrets.

## 📌 Next Steps
Deploy frontend app or API to frontend VM

Harden NSG rules for frontend-to-backend or frontend-to-SQL access

Add architecture diagram and flow documentation
