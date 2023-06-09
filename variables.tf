variable "name" {
  type        = string
  description = "(optional) describe your variable"
}
variable "identifier_uris" {
  type        = list(string)
  description = "(optional) describe your variable"
}
variable "sign_in_audience" {
  type        = string
  default     = "AzureADMyOrg"
  description = "(optional) describe your variable"
}

variable "app_roles" {
  type = list(object({
    allowed_member_types = optional(list(string), ["User"])
    description          = optional(string, "App Role")
    display_name         = string
    enabled              = optional(bool, true)
    id                   = string
    value                = optional(string)
  }))
  default     = []
  description = "(optional) describe your variable"
}
variable "group_membership_claims" {
  type        = list(string)
  default     = ["ApplicationGroup"]
  description = "(optional) describe your variable"
}


variable "required_resource_access" {
  type = list(object({
    resource_app_id = string
    resource_access = list(object({
      id   = string
      type = string
    }))
  }))
  default     = []
  description = "(optional) describe your variable"
}
variable "consent_resource_access" {
  type = list(object({
    resource_app_id = string
    resource_access = string
  }))
  default     = []
  description = "(optional) describe your variable"
}
variable "web" {
  type = list(object({
    homepage_url  = string
    logout_url    = optional(string)
    redirect_uris = set(string)
    implicit_grant = optional(object({
      access_token_issuance_enabled = optional(bool, false)
      id_token_issuance_enabled     = optional(bool, false)
    }), {})
  }))
  default     = []
  description = "(optional) describe your variable"
}

variable "public_client" {
  type = list(object({
    redirect_uris = set(string)
  }))
  default     = []
  description = "(optional) describe your variable"
}




variable "assigned_groups" {
  type = list(object({
    group_id    = string
    app_role_id = optional(string, "00000000-0000-0000-0000-000000000000")
  }))
  default     = []
  description = "(optional) describe your variable"
}
