
name = "ArgoCD Dev GCP"
identifier_uris = [
  "https://argocd.dev.gcp.logsr.life/auth/callback"
  #   ,
  #   "http://localhost:8085/auth/callback"
]

# group_membership_claims = ["SecurityGroup"]

required_resource_access = [{
  resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph

  resource_access = [{
    id   = "df021288-bdef-4463-88db-98f22de89214" # User.Read.All
    type = "Role"
  }]
}]
consent_resource_access = [{
  resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph
  resource_access = "df021288-bdef-4463-88db-98f22de89214"
}]

web = [{
  homepage_url = "https://argocd.dev.gcp.logsr.life"
  redirect_uris = [
    "https://argocd.dev.gcp.logsr.life/auth/callback"
  ]
}]

public_client = [{
  redirect_uris = ["http://localhost:8085/auth/callback"]
}]
