##-----------------------------------------------------------------------------
## Naming convention
##-----------------------------------------------------------------------------
variable "custom_name" {
  type        = string
  default     = null
  description = "Override default naming convention"
}

variable "resource_position_prefix" {
  type        = bool
  default     = true
  description = <<EOT
Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.

- If true, the keyword is prepended: "vnet-core-dev".
- If false, the keyword is appended: "core-dev-vnet".

This helps maintain naming consistency based on organizational preferences.
EOT
}

##-----------------------------------------------------------------------------
## Labels
##-----------------------------------------------------------------------------
variable "name" {
  type        = string
  default     = "core"
  description = "Name (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "managedby" {
  type        = string
  default     = "terraform-az-modules"
  description = "ManagedBy, eg 'terraform-az-modules'."
}

variable "extra_tags" {
  type        = map(string)
  default     = {}
  description = "Extra tags to apply to resources."
}

variable "repository" {
  type        = string
  default     = "https://github.com/terraform-az-modules/terraform-azurerm-service-principal"
  description = "Terraform current module repo"

  validation {
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "location" {
  type        = string
  default     = "centralus"
  description = "Azure region for resources."
}

variable "deployment_mode" {
  type        = string
  default     = "terraform"
  description = "Specifies how the infrastructure/resource is deployed."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment", "location"]
  description = "Order of labels used to construct resource names or tags."
}

##-----------------------------------------------------------------------------
## Global Variables
##-----------------------------------------------------------------------------
variable "enable" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

## -----------------------------------------------------------------------------
## Application / Identity
## -----------------------------------------------------------------------------
variable "sign_in_audience" {
  type        = string
  default     = "AzureADMyOrg"
  description = "The Microsoft account types that are supported for the current application"
}

variable "identifier_uris" {
  type        = list(string)
  default     = []
  description = "A set of URIs that uniquely identify the application"
}

variable "logo_image" {
  type        = string
  default     = null
  description = "Base64 encoded logo image for the application"
}

variable "description" {
  type        = string
  default     = null
  description = "Description of the service principal"
}

## -----------------------------------------------------------------------------
## Service Principal Behaviour
## -----------------------------------------------------------------------------
variable "alternative_names" {
  type        = list(string)
  default     = []
  description = "Alternative names used to identify the service principal"
}

variable "account_enabled" {
  type        = bool
  default     = true
  description = "Whether the service principal account is enabled"
}

variable "app_role_assignment_required" {
  type        = bool
  default     = false
  description = "Whether app role assignment is required before issuing tokens"
}

variable "use_existing" {
  type        = bool
  default     = false
  description = "Whether to import an existing service principal"
}

## -----------------------------------------------------------------------------
## Authentication / Sign-In Settings
## -----------------------------------------------------------------------------
variable "device_only_auth_enabled" {
  type        = bool
  default     = false
  description = "Whether the application supports device-only authentication"
}

variable "fallback_public_client_enabled" {
  type        = bool
  default     = false
  description = "Whether the application is a public client"
}

variable "group_membership_claims" {
  type        = list(string)
  default     = []
  description = "Groups claim configuration for issued tokens"
}

variable "preferred_single_sign_on_mode" {
  type        = string
  default     = ""
  description = "Preferred single sign-on mode (oidc, password, saml)"
}

variable "login_url" {
  type        = string
  default     = null
  description = "Login URL for IdP-initiated sign-on"
}

variable "relay_state" {
  type        = string
  default     = null
  description = "Relay state used in SAML single sign-on"
}

## -----------------------------------------------------------------------------
## Password / Secret Rotation
## -----------------------------------------------------------------------------
variable "password_end_date" {
  type        = string
  default     = null
  description = "RFC3339 timestamp after which the password expires"
}

variable "password_rotation_in_years" {
  type        = number
  default     = null
  description = "Number of years before password rotation"
}

variable "password_rotation_in_days" {
  type        = number
  default     = null
  description = "Number of days before password rotation"
}

variable "password_display_name" {
  type        = string
  default     = "rbac"
  description = "Display name for the service principal password"
}

## -----------------------------------------------------------------------------
## Certificate Configuration
## -----------------------------------------------------------------------------
variable "enable_service_principal_certificate" {
  type        = bool
  default     = false
  description = "Enable certificate-based authentication for the service principal"
}

variable "certificate_value" {
  type        = string
  default     = ""
  description = "Certificate data (PEM, base64 DER, or hex DER)"
}

variable "certificate_encoding" {
  type        = string
  default     = "pem"
  description = "Encoding of the certificate data"
}

variable "certificate_type" {
  type        = string
  default     = "AsymmetricX509Cert"
  description = "Type of certificate key"
}

variable "certificate_subject_name" {
  type        = string
  default     = "sp-certificate"
  description = "Subject name for the token signing certificate"
}

variable "key_id" {
  type        = string
  default     = null
  description = "Optional UUID to uniquely identify the certificate"
}

variable "end_date" {
  type        = string
  default     = ""
  description = "RFC3339 end date for certificate or password validity"
}

## -----------------------------------------------------------------------------
## Role Assignments
## -----------------------------------------------------------------------------
variable "assignments" {
  type = list(object({
    scope                = string
    role_definition_name = string
    description          = optional(string)
  }))
  default     = []
  description = "Role assignments for the service principal"
}

## -----------------------------------------------------------------------------
## Notifications / Metadata
## -----------------------------------------------------------------------------
variable "notes" {
  type        = string
  default     = null
  description = "Free-form text used to capture operational or administrative notes for the service principal"
}

variable "notification_email_addresses" {
  type        = list(string)
  default     = []
  description = "Email addresses that receive notifications when the service principal's certificate is near expiration (used mainly for SAML token signing certificates)"
}