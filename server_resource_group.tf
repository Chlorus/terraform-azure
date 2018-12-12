resource "azurerm_resource_group" "gaming" {
    name = "ServersResourceGroup0"
    location = "Central US"

    tags { 
        environment = "Dev"
    }
}
