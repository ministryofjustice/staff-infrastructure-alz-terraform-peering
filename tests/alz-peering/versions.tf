terraform {
  required_version = ">=1.9.8"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.33.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "samojtfstate001"
    resource_group_name  = "rg-terraform-statefiles-001"
    container_name       = "tfstatepullrequest"
    key                  = "alzpeering.terraform.tfstate"
  }
}
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}
