FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "MovieExplorer.API.dll"]


# To build and run this Dockerfile, use the following commands:
# docker build --platform linux/amd64 -t movieexplorer-api:local .
# docker run --rm -p 8080:8080 movieexplorer-api:local


# To push to acr
#     az acr login --name lewisacr
#     docker tag movieexplorer-api:local lewisacr.azurecr.io/movieexplorer-api:latest
#     docker push lewisacr.azurecr.io/movieexplorer-api:latest
