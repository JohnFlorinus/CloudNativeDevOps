targetScope = 'subscription'

param sharedLocation string = 'swedencentral'
param rgName string = 'rg-todolistiac'
param dbServerName string = 'tododbserveriac'
param dbSqlName string = 'tododbiac'
param ctrPrefixName string = 'todoctriac' // Prefix for ACR, Environment, and Container App Resource Names

// 1. Deploy the Resource Group module
module rgDeploy 'rg.bicep' = {
  name: 'ResourceGroupDeployment'
  params: {
    name: rgName
    location: sharedLocation
  }
}

// 2. Create SQL Database
module sqlDeploy 'db.bicep' = {
  name: 'SqlResourcesDeployment'
  scope: resourceGroup(rgName)
  params: {
    dbServerName: dbServerName
    dbSqlName: dbSqlName
    location: sharedLocation
  }
  // This ensures the RG is created before the SQL resources are deployed.
  dependsOn: [
    rgDeploy
  ]
}

// 3. Create Container Resources (ACR, Container Apps, Container Environment)
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
