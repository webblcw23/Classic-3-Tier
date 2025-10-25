# 🎬 MovieExplorer

A cloud-native, full-stack movie browsing app built for recruiters and platform engineers alike. Designed to showcase modular Azure infrastructure, Dockerized deployment, and a polished UI/UX inspired by cinematic storytelling.

---

## 🧩 Tech Stack

| Layer        | Tech Used                              |
|--------------|-----------------------------------------|
| **Frontend** | React + Vite + Tailwind CSS             |
| **Backend**  | Node.js + Express + mssql               |
| **Database** | Azure SQL Database                      |
| **Infra**    | Azure App Service + Azure Container Registry + Azure Key Vault |
| **IaC**      | Terraform (modular, reusable architecture) |
| **CI/CD**    | Azure DevOps Pipelines (coming soon)    |

---

## 📸 Screenshots

Screenshots can be found in the Screenshots folder at the root of the project.
or in my Portfolio Web Page - https://lewis-webb-portfolio-webpage-ezczesgjdtgmdfb3.uksouth-01.azurewebsites.net/# 
---

## 🧠 Features

- 🎞️ Browse a curated list of iconic films
- 🔍 Click any movie card to view full details
- 🧵 Clean, responsive UI with Tailwind styling
- 🔐 Secrets managed via Azure Key Vault
- 🐳 Dockerized frontend and backend
- ☁️ Deployed to Azure App Services via ACR
- 🧱 Modular Terraform infrastructure (3-tier architecture)

---

## 📁 Project Structure

movieexplorer/ ├── frontend/ # React + Vite + Tailwind UI ├── backend/ # Express API with Azure SQL integration ├── terraform/ # Modular IaC for Azure resources └── README.md # You're reading it!

## Code

---

## ⚙️ Local Development

### Prerequisites

- Node.js + npm
- Docker
- Azure CLI (for deployment)
- Terraform CLI (for infra)

### Run Locally

Bash
# Frontend
cd frontend
npm install
npm run dev

# Backend
cd ../backend
npm install
node index.js
📦 Deployment
1. Build & Push Docker Images
bash
# Frontend
cd frontend
npm run build
docker build --platform linux/amd64 -t movieexplorer-frontend .
docker tag movieexplorer-frontend lewisacr.azurecr.io/movieexplorer-frontend:latest
docker push lewisacr.azurecr.io/movieexplorer-frontend:latest

# Backend
cd ../backend
docker build --platform linux/amd64 -t movieexplorer-backend .
docker tag movieexplorer-backend lewisacr.azurecr.io/movieexplorer-backend:latest
docker push lewisacr.azurecr.io/movieexplorer-backend:latest
2. Restart App Services
Use Azure Portal or CLI to restart both frontend and backend App Services.

🧪 Validation
✅ Movie cards show title, genre, year, and rating

✅ Clicking a card shows full description

✅ “Back to Movie List” button returns to homepage

✅ API endpoints return expected JSON

✅ All secrets injected via environment variables

📚 Future Enhancements
🔐 Add authentication (e.g., Azure AD B2C)

🧵 Add filtering/sorting by genre, year, rating

📦 Implement CI/CD with Azure DevOps Pipelines for full automation - Perhaps to add/deploy new films via sql deploy script

📈 Add monitoring with Application Insights

🧪 Add unit and integration tests

👋 About the Author
Lewis Webb — Cloud-native DevOps & Platform Engineer 🎯 
Please check out my portfolio at  https://lewis-webb-portfolio-webpage-ezczesgjdtgmdfb3.uksouth-01.azurewebsites.net/# 
as well as my other GitHub projects and my LinkedIn. 

