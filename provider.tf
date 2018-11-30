#Configuration for Azure
provider "azurerm" {
    environment = "public"
}  

#Remote state

terraform {
    backend "azurerm" {
        storage_account_name = "chlorusterraform"
        container_name       = "tfstate"
         key                  = "prod.terraform.tfstate"
    }
}


