param location string
param containerPrefix string = 'todocontainer'
param acrAdminUsername string = 'admin01'
@secure()
param acrAdminPassword string = 'Jensen100'

// --- Container Registry (ACR) ---
resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: '${containerPrefix}-ACR'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

// --- Container Apps Environment (Shared Environment) ---
resource environment 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: '${containerPrefix}-env'
  location: location
  properties: {
  }
}

// --- Container App Registry Credentials (Secret) ---
var acrLoginSecret = {
  server: acr.properties.loginServer
  username: acrAdminUsername
  passwordSecretRef: 'acr-password'
}

// --- Container App: todo-frontend ---
resource frontendApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: '${containerPrefix}-frontend'
  location: location
  properties: {
    managedEnvironmentId: environment.id
    configuration: {
      activeRevisionsMode: 'Single'
      secrets: [
        {
          name: 'acr-password'
          value: acrAdminPassword
        }
      ]
      registries: [ // Link the secret to the registry login
        acrLoginSecret
      ]
      ingress: {
        external: true
        targetPort: 8080
        transport: 'http'
        traffic: [
          {
            latestRevision: true
            weight: 100
          }
        ]
      }
    }
    template: {
      containers: [
        {
          name: 'todo-frontend-container'
          image: '${acr.properties.loginServer}/todo-frontend:latest'
          resources: {
            cpu: 1
            memory: '2.0Gi'
          }
        }
      ]
    }
  }
}

// --- Container App: todo-backend ---
resource backendApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: '${containerPrefix}-backend'
  location: location
  properties: {
    managedEnvironmentId: environment.id
    configuration: {
      activeRevisionsMode: 'Single'
      secrets: [
        {
          name: 'acr-password'
          value: acrAdminPassword
        }
      ]
      registries: [
        acrLoginSecret
      ]
      ingress: {
        external: true
        targetPort: 8080
        transport: 'http'
        traffic: [
          {
            latestRevision: true
            weight: 100
          }
        ]
      }
    }
    template: {
      containers: [
        {
          name: 'todo-backend-container'
          image: '${acr.properties.loginServer}/todo-backend:latest'
          resources: {
            cpu: 1
            memory: '2.0Gi'
          }
        }
      ]
    }
  }
}

output frontendFqdn string = frontendApp.properties.latestRevisionFqdn
output backendFqdn string = backendApp.properties.latestRevisionFqdn
output acrLoginServer string = acr.properties.loginServer
