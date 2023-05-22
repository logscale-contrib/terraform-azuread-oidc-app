
resource "azuread_application_password" "secret" {
  application_object_id = azuread_application.app.object_id
}

resource "kubernetes_secret" "secret" {
  metadata {
    name      = var.secret_name
    namespace = var.secret_namespace
  }

  data = {
    var.secret_key = azuread_application_password.secret.value
  }


}
