##-----------------------------------------------------------------------------
## Permissions, Roles, and Policies
##-----------------------------------------------------------------------------
resource "azurerm_role_assignment" "main" {
  count                = var.enable ? length(var.assignments) : 0
  description          = try(var.assignments[count.index].description, null)
  scope                = var.assignments[count.index].scope
  role_definition_name = var.assignments[count.index].role_definition_name
  principal_id         = azuread_service_principal.main[0].object_id
}
