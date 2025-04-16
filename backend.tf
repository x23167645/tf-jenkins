terraform {
  backend "azurerm" {
    resource_group_name  = "ansible-rg"
    storage_account_name = "terraformjenkinstate"   # must be globally unique
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
