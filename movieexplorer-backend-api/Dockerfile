# movieexplorer-backend/Dockerfile
FROM node:20 
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 5050
CMD ["node", "index.js"]




# Local dotnet test - need to run backend and frontend
#cd movieexplorer-backend-api
#dotnet run --project MovieExplorer.API.csproj
#cd ../movieexplorer-frontend
#npm run dev
#then view http://localhost:5173/ in browser



# To build and run this Dockerfile, use the following commands:
# docker build --platform linux/amd64 -t movieexplorer-backend .
# docker run --rm -p 8080:8080 movieexplorer-backend


# To push to acr
#     az acr login --name lewisacr
#     docker tag movieexplorer-backend lewisacr.azurecr.io/movieexplorer-backend:latest
#     docker push lewisacr.azurecr.io/movieexplorer-backend
