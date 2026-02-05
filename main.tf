##-----------------------------------------------------------------------------
# Labels
##-----------------------------------------------------------------------------
module "labels" {
  source          = "terraform-az-modules/tags/azurerm"
  version         = "1.0.2"
  name            = var.custom_name == null ? var.name : var.custom_name
  location        = var.location
  environment     = var.environment
  managedby       = var.managedby
  label_order     = var.label_order
  repository      = var.repository
  deployment_mode = var.deployment_mode
  extra_tags      = var.extra_tags
}

##-----------------------------------------------------------------------------
# Application
##-----------------------------------------------------------------------------
resource "azuread_application" "main" {
  count                          = var.enable ? 1 : 0
  display_name                   = var.resource_position_prefix ? format("%s-service-principal", local.name) : format("%s-service-principal", local.name)
  identifier_uris                = var.identifier_uris
  device_only_auth_enabled       = var.device_only_auth_enabled
  fallback_public_client_enabled = var.fallback_public_client_enabled
  group_membership_claims        = var.group_membership_claims
  logo_image                     = var.logo_image
  owners                         = [data.azuread_client_config.current.object_id]
  sign_in_audience               = var.sign_in_audience
}

##-----------------------------------------------------------------------------
# Service Principal
##-----------------------------------------------------------------------------
resource "azuread_service_principal" "main" {
  count                         = var.enable ? 1 : 0
  client_id                     = azuread_application.main[0].client_id
  owners                        = [data.azuread_client_config.current.object_id]
  alternative_names             = var.alternative_names
  account_enabled               = var.account_enabled
  app_role_assignment_required  = var.app_role_assignment_required
  description                   = var.description
  login_url                     = var.login_url
  notes                         = var.notes
  notification_email_addresses  = var.notification_email_addresses
  preferred_single_sign_on_mode = var.preferred_single_sign_on_mode
  use_existing                  = var.use_existing
  saml_single_sign_on {
    relay_state = var.relay_state
  }
}

##-----------------------------------------------------------------------------
# Time Rotating
##-----------------------------------------------------------------------------
resource "time_rotating" "main" {
  rotation_rfc3339 = var.password_end_date
  rotation_years   = var.password_rotation_in_years
  rotation_days    = var.password_rotation_in_days
  triggers = {
    end_date = var.password_end_date
    years    = var.password_rotation_in_years
    days     = var.password_rotation_in_days
  }
}

##-----------------------------------------------------------------------------
# Service Principal Password
##-----------------------------------------------------------------------------
resource "azuread_service_principal_password" "main" {
  count                = var.enable && var.enable_service_principal_certificate == false ? 1 : 0
  service_principal_id = azuread_service_principal.main[0].id
  display_name         = var.password_display_name
  end_date             = var.end_date
  rotate_when_changed = {
    rotation = time_rotating.main.id
  }
}

##-----------------------------------------------------------------------------
# Service Principal Certificate
##-----------------------------------------------------------------------------
resource "azuread_service_principal_certificate" "main" {
  count                = var.enable && var.enable_service_principal_certificate == true ? 1 : 0
  service_principal_id = azuread_service_principal.main[0].id
  type                 = var.certificate_type
  encoding             = var.certificate_encoding
  key_id               = var.key_id
  value                = var.certificate_value
  end_date             = var.end_date
}

##-----------------------------------------------------------------------------
# Token Signing Certificate
##-----------------------------------------------------------------------------
resource "azuread_service_principal_token_signing_certificate" "main" {
  count                = var.enable && var.enable_service_principal_certificate == true ? 1 : 0
  service_principal_id = azuread_service_principal.main[0].id
  display_name         = "CN=${var.certificate_subject_name}"
  end_date             = var.end_date
}