# Utiliza la imagen base de .NET 7.0
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80

# Utiliza la imagen base de SDK para compilar la aplicación
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["TenorGifViewer/TenorGifViewer.csproj", "TenorGifViewer/"]
RUN dotnet restore "TenorGifViewer/TenorGifViewer.csproj"
COPY . .
WORKDIR "/src/TenorGifViewer"
RUN dotnet build "TenorGifViewer.csproj" -c Release -o /app/build

# Publica la aplicación
FROM build AS publish
RUN dotnet publish "TenorGifViewer.csproj" -c Release -o /app/publish

# Construye la imagen final
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TenorGifViewer.dll"]
