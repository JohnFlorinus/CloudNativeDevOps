targetScope = 'subscription'

param sharedLocation string = 'swedencentral'
param rgName string = 'rg-todolist-test2'
param dbServerName string = 'ToDoDBServer2'
param dbSqlName string = 'ToDoDB2'

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
  }
  dependsOn: [
    rgDeploy
  ]
}
