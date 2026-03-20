provider "azurerm" {
  features {}
}

module "service-principal" {
  source = "../../"
}
