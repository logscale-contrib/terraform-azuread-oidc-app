data "azuread_client_config" "current" {}


resource "azuread_application" "app" {
  display_name    = var.name
  identifier_uris = var.identifier_uris
  # logo_image       = filebase64("/path/to/logo.png")
  owners           = [data.azuread_client_config.current.object_id]
  sign_in_audience = var.sign_in_audience


  group_membership_claims = var.group_membership_claims

  dynamic "required_resource_access" {
    for_each = var.required_resource_access
    content {
      resource_app_id = required_resource_access.value["resource_app_id"]
      dynamic "resource_access" {
        for_each = required_resource_access.value["resource_access"]
        content {
          id   = resource_access.value["id"]
          type = resource_access.value["type"]
        }
      }
    }
  }

  dynamic "web" {
    for_each = var.web
    content {
      homepage_url  = web.value["homepage_url"]
      logout_url    = web.value["logout_url"]
      redirect_uris = web.value["redirect_uris"]
      implicit_grant {
        access_token_issuance_enabled = web.value["implicit_grant"]["access_token_issuance_enabled"]
        id_token_issuance_enabled     = web.value["implicit_grant"]["id_token_issuance_enabled"]
      }
    }
  }

  dynamic "public_client" {
    for_each = var.public_client
    content {
      redirect_uris = public_client.value["redirect_uris"]
    }

  }
}



resource "azuread_service_principal" "app" {
  application_id = azuread_application.app.application_id

  app_role_assignment_required = false
  owners                       = [data.azuread_client_config.current.object_id]

  
  preferred_single_sign_on_mode = "oidc"
  use_existing = true

  feature_tags {
    enterprise = true
    gallery    = true
  }


}
resource "azuread_service_principal" "target" {
  count          = length(var.consent_resource_access)
  application_id = var.consent_resource_access[count.index].resource_app_id
  use_existing   = true
}
resource "azuread_app_role_assignment" "consent" {
  count               = length(var.consent_resource_access)
  principal_object_id = azuread_service_principal.app.object_id
  resource_object_id  = azuread_service_principal.target[count.index].object_id
  app_role_id         = var.consent_resource_access[count.index].resource_access
}

