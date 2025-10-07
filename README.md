💡 Azure Interview-Ready Infrastructure: Secure SQL + Bastion Access
📌 Project Overview
This Terraform-based Azure infrastructure project provisions a secure, multi-tier network with:

🔐 Managed Azure SQL Database behind a Private Endpoint

🧱 Subnet-level isolation with NSGs for frontend, backend, and DB tiers

🛡️ Azure Bastion for secure VM access—no public IPs

📦 Modular Terraform architecture for reusability and clarity

Designed to showcase platform engineering skills for infrastructure-focused interviews.

🧱 Architecture Summary
Layer	Resources
Networking	VNet with isolated subnets: frontend, backend, db, bastion
Security	NSGs with precise inbound rules (HTTP, app port, SQL 1433)
Compute	Linux VMs (frontend + backend) with Bastion-only access
Database	Azure SQL Server + Database with Private Endpoint
DNS	Private DNS Zone linked to VNet for internal name resolution
🚀 Deployment Steps
Initialize Terraform

bash
terraform init
Review Plan

bash
terraform plan
Apply Infrastructure

bash
terraform apply
Verify Resources

SQL Server and DB deployed

Private Endpoint in DB subnet

Bastion host reachable

NSGs correctly linked

🔍 Connectivity Testing
After deployment:

SSH into backend VM via Bastion

Run:

bash
nslookup <sql-server-name>.database.windows.net
sqlcmd -S <sql-server-name>.database.windows.net -U <admin> -P <password>
📁 Module Structure
Code
modules/
├── network/       # VNet, subnets
├── nsg/           # NSGs and associations
├── compute/       # Linux VMs
├── bastion/       # Bastion host
├── sql/           # SQL Server, DB, Private Endpoint
🧠 Key Concepts Demonstrated
Azure Private Endpoint + DNS zone integration

Bastion-only VM access (no public IPs)

NSG rule design with CIDR-based isolation

Terraform module composition and variable passing

Interview-grade infrastructure polish