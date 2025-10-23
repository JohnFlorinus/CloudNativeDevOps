targetScope = 'resourceGroup'

param location string
param dbServerName string
param dbSqlName string
param administratorLogin string = 'admin01'
@secure()
param administratorLoginPassword string = 'Jensen100'

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: dbServerName
  location: location
  properties: {
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

resource sqlDB 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: dbSqlName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}
