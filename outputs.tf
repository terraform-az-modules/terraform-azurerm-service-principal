##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "service_principal_name" {
  description = "The object id of service principal. Can be used to assign roles to user."
  value       = try(azuread_service_principal.main[0].display_name, null)
}

output "service_principal_object_id" {
  description = "The object id of service principal. Can be used to assign roles to user."
  value       = try(azuread_service_principal.main[0].object_id, null)
}

output "service_principal_client_id" {
  description = "The client ID of the service principal. Can be used to assign roles to users."
  value       = try(azuread_service_principal.main[0].client_id, null)
}

output "client_id" {
  description = "The client ID of the Azure AD application created."
  value       = try(azuread_application.main[0].client_id, null)
}

output "client_secret" {
  description = "Password for service principal."
  value       = try(azuread_service_principal_password.main[0].value, null)
  sensitive   = true
}

output "service_principal_password" {
  description = "Password for service principal."
  value       = try(azuread_service_principal_password.main[0].value, null)
  sensitive   = true
}