targetScope = 'subscription'

param sharedLocation string = 'swedencentral'
param rgName string = 'rg-todolist4'
param dbServerName string = 'tododbserver4'
param dbSqlName string = 'tododb4'
param ctrPrefixName string = 'todoctr4' // Prefix for ACR, Environment, and Container App Resource Names
param kvName string = 'todokv4'

// Resource Group
module rgDeploy 'rg.bicep' = {
  name: 'ResourceGroupDeployment'
  params: {
    name: rgName
    location: sharedLocation
  }
}

// SQL Database
module sqlDeploy 'db.bicep' = {
  name: 'SqlResourcesDeployment'
  scope: resourceGroup(rgName)
  params: {
    dbServerName: dbServerName
    dbSqlName: dbSqlName
    location: sharedLocation
  }
  // RG created before the resources are deployed.
  dependsOn: [
    rgDeploy
  ]
}

// Container Apps, Environment, ACR
module containerDeploy 'containers.bicep' = {
  name: 'ContainerResourcesDeployment'
  scope: resourceGroup(rgName)
params: {
    location: sharedLocation
    containerPrefix: ctrPrefixName
  }
  dependsOn: [
    rgDeploy
  ]
}

// Key Vault
module keyVaultDeploy 'keyvault.bicep' = {
  name: 'KeyVaultDeployment'
  scope: resourceGroup(rgName)
  params: {
    location: sharedLocation
    keyVaultName: kvName
    backendContainerAppPrincipalId: containerDeploy.outputs.backendContainerAppPrincipalId
  }
  dependsOn: [
    containerDeploy
  ]
}
