<!-- BEGIN_TF_DOCS -->

# Terraform Azure Service Principal Module

This directory contains an example usage of the **terraform-azurerm-service-principle**.It demonstrates how to use the module to deploy a service principal with custom certificate credentials and subscription-level role assignments 

---

## 📋 Requirements

| Name      | Version   |
|-----------|-----------|
| Terraform | >= 1.6.6  |
| Azurerm   | >= 3.116.0|

---

## 🔌 Providers

None specified in this example.

---

## 📦 Modules


| Name                | Source | Version |
|---------------------|--------|---------|
| service-principal   | ../..  | n/a     |

---

## 🏗️ Resources

No resources are directly created in this example.

---

## 🔧 Inputs

No input variables are defined in this example.

---

## 📤 Outputs

| Name                          | Description                                                          | Sensitive |
|-------------------------------|----------------------------------------------------------------------|-----------|
| service_principal_name        | The name of the service principal                                    | no        |
| service_principal_object_id   | The object id of service principal. Can be used to assign roles to user | no     |
| service_principal_application_id | The application id of service principal                           | no        |
| client_id                     | The application id of AzureAD application created                    | no        |
| client_secret                 | Password for service principal                                       | yes       |
| service_principal_password    | Password for service principal                                       | yes       |

<!-- END_TF_DOCS -->
