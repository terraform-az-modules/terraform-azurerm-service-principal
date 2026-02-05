##-----------------------------------------------------------------------------
## Provider
##-----------------------------------------------------------------------------
provider "azurerm" {
  features {}
}

##-----------------------------------------------------------------------------
## Service Principal
##-----------------------------------------------------------------------------
module "service-principal" {
  source                               = "../.."
  name                                 = "core"
  environment                          = "dev"
  label_order                          = ["name", "environment", "location"]
  enable_service_principal_certificate = true
  end_date                             = "2028-02-06T00:00:00Z"
  certificate_value                    = <<EOF
MIIDDTCCAfWgAwIBAgIUKeePYRVfaVL/2zhpkY2Nx7JlUpwwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAwwLY29yZS1kZXYtc3AwHhcNMjYwMjA1MTk1MjU4WhcNMjgw
ODA2MTk1MjU4WjAWMRQwEgYDVQQDDAtjb3JlLWRldi1zcDCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAJeFJnpk744yutbSxfOEhb6MJbbE5Nke2+jUbeeZ
/lwOWP3Kh33MUiRaCkRJ5cA5h8oc9Xw5iqvwDfS5hSji6zIdo7+Qphv2XBbFkmqj
RrMr7Ka4B6b1mmJla5rilOyEQmY20Bf/mEYfFIBWHGzYlhzXkfGR2JhrR2Ts322Y
MeKI0bqZ8HY+ILehTv1iVJHhhZrIANSrvreIWg2ubrLDC/+jlcUCAl5NeOF5RhWy
01zDwQ1wVgDCdr7RpyvPi+gmR2P3mnZEdprRndRMJut7F9z0FkiMtk9qTorIeP0d
E7M5fKfmF7vEowg37VVVqKae5eCAUffH0cEq63P2GEV7xJUCAwEAAaNTMFEwHQYD
VR0OBBYEFEepkU4R7tXvM++T5Z9otPXTddRKMB8GA1UdIwQYMBaAFEepkU4R7tXv
M++T5Z9otPXTddRKMA8GA1UdEwEB/wQFMAMBAf8wDQYJKoZIhvcNAQELBQADggEB
ACs7mumJd5dctzq/dzYXXzWdSICwfwxDtA0bzEq2oakI507E92nYzT9Uoap1JP2u
WzF2JK6ief2PUBenyAWpMT9TGszcHL9kBX5eHJwLJQN6z5TM+Y4B0QUl33yKa180
dYFZXtoxcZdmeE76Y3XrAmadMcS4rDnmpAqfrilaUT/wwsdwYGQ+6VRbTAFbcbpi
G72AFifOqW5ohhGuMmx0Zxw+7eYwzhcy1chEECRWS/1HfO12n7BaASd3iJE0WWbG
a/trn/3qdP0aICEngaklfSpKn3v3xMfnr9WVIcJ2kY/roLZpfXe8F9LUlF64UF/X
j9h/ewYWQ8nMYpy5XEQV+UE=
EOF
  password_rotation_in_years           = 1
  assignments = [
    {
      scope                = "/subscriptions/1ac2caa4-336e-4daa-b8f1-0fbabe2d4b11"
      role_definition_name = "Contributor"
    },
  ]
}