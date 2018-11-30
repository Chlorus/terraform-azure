resource "azurerm_resource_group" "gaming" {
    name = "ServersResourceGroup0"
    location = "West Central US"

    tags { 
        environment = "Dev"
    }
}
