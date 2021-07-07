terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  subscription_id = "c2ec4ca2-f06a-4884-8724-6330700ab292"
  client_id       = "01cf4eea-c092-4d99-9866-99f1a40f5a89"
  tenant_id       = "1a6853dc-4cc2-45d6-ba4c-e2f6097eecda"
  client_secret   = "************************************"
}

resource "azurerm_resource_group" "tm" {
  name     = "tm-resources"
  location = "West Europe"
}

# NOTE: the Name used for Redis needs to be globally unique
resource "azurerm_redis_cache" "tm" {
  name                = "tm-cache"
  location            = azurerm_resource_group.tm.location
  resource_group_name = azurerm_resource_group.tm.name
  capacity            = 2
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}