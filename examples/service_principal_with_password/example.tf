##-----------------------------------------------------------------------------
## Provider
##-----------------------------------------------------------------------------
provider "azurerm" {
  features {}
  subscription_id = "1ac2caa4-336e-4daa-b8f1-0fbabe2d4b11"
}

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
      scope                = "/subscriptions/1ac2caa4-336e-4daa-b8f1-0fbabe2d4b11"
      role_definition_name = "Contributor"
    },
  ]
}