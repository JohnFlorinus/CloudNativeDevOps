param location string
param containerPrefix string

resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: '${containerPrefix}acr'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

var acrAdminCredentials = listCredentials(acr.id, acr.apiVersion)
var acrAdminUsername = acrAdminCredentials.username // Använd det autogenererade användarnamnet
var acrAdminPassword = acrAdminCredentials.passwords[0].value // Använd autogenererade lösenordet

resource environment 'Microsoft.App/managedEnvironments@2024-03-01' = {
  name: '${containerPrefix}env'
  location: location
  properties: {
  }
}

var acrLoginSecret = {
  server: acr.properties.loginServer
  username: acrAdminUsername
  passwordSecretRef: 'acr-password'
}

var dummyImage = 'nginx:latest'

resource frontendApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: '${containerPrefix}frontend'
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
          image: dummyImage // replace manually with this: ${acr.properties.loginServer}/todo-frontend:latest
          resources: {
            cpu: 1
            memory: '2.0Gi'
          }
        }
      ]
    }
  }
}

resource backendApp 'Microsoft.App/containerApps@2024-03-01' = {
  name: '${containerPrefix}backend'
  location: location
  identity: {
    type: 'SystemAssigned' // System-Assigned Managed Identity for Key Vault RBAC
  }
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
          image: dummyImage // replace manually with this: ${acr.properties.loginServer}/todo-backend:latest
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

// for key vault RBAC
output backendContainerAppPrincipalId string = backendApp.identity.principalId
