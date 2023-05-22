output "application_id" {
  value = azuread_application.app.application_id
}
output "directory_tenant_id" {
  value = data.azuread_client_config.current.tenant_id
}
output "issuer" {
  value = "https://login.microsoftonline.com/${data.azuread_client_config.current.tenant_id}/v2.0"
}
