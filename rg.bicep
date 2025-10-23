targetScope='subscription'

// resourceGroup.bicep
param name string
param location string

resource rg 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: name
  location: location
}
