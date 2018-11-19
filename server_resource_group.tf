resource "azurerm_resource_group" "servers" {
    name = "ServersResourceGroup0"
    location = "West Central US"

    tags { 
        environment = "Dev"
    }
}
