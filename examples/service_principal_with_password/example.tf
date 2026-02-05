##-----------------------------------------------------------------------------
## Provider
##-----------------------------------------------------------------------------
provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

##-----------------------------------------------------------------------------
## Service Principal
##-----------------------------------------------------------------------------
module "service-principal" {
  source                     = "../.."
  name                       = "core"
  environment                = "dev"
  label_order                = ["name", "environment", "location"]
  password_rotation_in_years = 2
  end_date                   = "2028-02-06T00:00:00Z"
  assignments = [
    {
      scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
      role_definition_name = "Contributor"
    },
  ]
}