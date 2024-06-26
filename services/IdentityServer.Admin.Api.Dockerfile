FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /
COPY ["src/IdentityServer.Admin.Api/IdentityServer.Admin.Api.csproj", "src/IdentityServer.Admin.Api/"]
COPY ["src/IdentityServer.Admin.EntityFramework.Shared/IdentityServer.Admin.EntityFramework.Shared.csproj", "src/IdentityServer.Admin.EntityFramework.Shared/"]
COPY ["src/IdentityServer.Admin.EntityFramework.SqlServer/IdentityServer.Admin.EntityFramework.SqlServer.csproj", "src/IdentityServer.Admin.EntityFramework.SqlServer/"]
COPY ["src/IdentityServer.Shared/IdentityServer.Shared.csproj", "src/IdentityServer.Shared/"]
COPY ["src/IdentityServer.Admin.EntityFramework.PostgreSQL/IdentityServer.Admin.EntityFramework.PostgreSQL.csproj", "src/IdentityServer.Admin.EntityFramework.PostgreSQL/"]
COPY ["src/IdentityServer.Admin.EntityFramework.MySql/IdentityServer.Admin.EntityFramework.MySql.csproj", "src/IdentityServer.Admin.EntityFramework.MySql/"]
COPY ["src/IdentityServer.Admin.EntityFramework.SqlServer/IdentityServer.Admin.EntityFramework.SqlServer.csproj", "src/IdentityServer.Admin.EntityFramework.SqlServer/"]
RUN dotnet restore "src/IdentityServer.Admin.Api/IdentityServer.Admin.Api.csproj"
COPY . .
WORKDIR "/src/IdentityServer.Admin.Api"
RUN dotnet build "IdentityServer.Admin.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "IdentityServer.Admin.Api.csproj" -c Release -o /app/publish

# Generate Dev Certs from SDKs
RUN dotnet dev-certs https --clean
RUN dotnet dev-certs https -ep /app/https/default-certificate.pfx -p changeme
RUN dotnet dev-certs https --trust

FROM base AS final
ARG HttpsCertName=aspnetapp
WORKDIR /app
COPY --from=publish /app/publish .
COPY --from=publish /app/https /https

ENV ASPNETCORE_Kestrel__Certificates__Default__Path=/https/default-certificate.pfx
ENV ASPNETCORE_Kestrel__Certificates__Default__Password=changeme
ENV ASPNETCORE_FORWARDEDHEADERS_ENABLED=true
ENV ASPNETCORE_URLS=https://+:44302;http://+:5000
ENTRYPOINT ["dotnet", "IdentityServer.Admin.Api.dll"]
