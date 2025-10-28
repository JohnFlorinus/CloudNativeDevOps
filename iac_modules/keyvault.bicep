param location string
param keyVaultName string
param backendContainerAppPrincipalId string // For Backend Container App Permission

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableRbacAuthorization: true
  }
}

// Role Definition ID for Key Vault Administrator
var keyVaultSecretsUserRoleDefinitionId = '/providers/Microsoft.Authorization/roleDefinitions/00482a5a-887f-4fb3-b363-3b7fe8e74483'

// RBAC Role Assignment for Backend App
resource kvRbacAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: keyVault
  name: guid(keyVault.id, backendContainerAppPrincipalId, keyVaultSecretsUserRoleDefinitionId)
  properties: {
    roleDefinitionId: keyVaultSecretsUserRoleDefinitionId
    principalId: backendContainerAppPrincipalId
    principalType: 'ServicePrincipal' // ServicePrincipal for Managed Identities
  }
}

output keyVaultName string = keyVault.name
