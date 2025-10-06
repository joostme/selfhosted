variable "DOMAIN" {
  description = "The domain the apps should use for subdomains"
}

variable "GROUPS" {
  description = "Groups"
  type = map(object({
    name  = string
    users = list(string)
  }))
}

variable "USERS" {
  description = "Users"
  type = map(object({
    name  = string
    email = string
  }))
}

variable "APPLICATIONS" {
  description = "IDs for Import statements"
  type = map(object({
    name  = string
    group = string
  }))
}

# Flows

import {
  id = "default-provider-authorization-implicit-consent"
  to = authentik_flow.authorization_implicit
}

resource "authentik_flow" "authorization_implicit" {
  name               = "Authorize Application"
  title              = "Redirecting to %(app)s"
  slug               = "default-provider-authorization-implicit-consent"
  designation        = "authorization"
  compatibility_mode = false
  authentication     = "require_authenticated"
}

import {
  id = "default-provider-invalidation-flow"
  to = authentik_flow.invalidation_flow
}

resource "authentik_flow" "invalidation_flow" {
  name               = "Logged out of application"
  title              = "You've logged out of %(app)s."
  slug               = "default-provider-invalidation-flow"
  designation        = "invalidation"
  compatibility_mode = false
}

# Remote-Fields Scope

resource "authentik_property_mapping_provider_scope" "remote_fields" {
  name       = "Remote-Fields"
  scope_name = "remote-fields"
  expression = <<EOF
return {
    "ak_proxy": {
        "user_attributes": {
            "additionalHeaders": {
                "Remote-User": user.username,
                "Remote-Email": user.email,
                "Remote-Name": user.name 
            }
        }
    }
}
EOF
}

## Users

resource "authentik_user" "user" {
  for_each = var.USERS
  username = each.key
  email    = each.value.email
  name     = each.value.name
  attributes = jsonencode({
    settings = {
      locale = "de"
    }
  })
}

## Groups

resource "authentik_group" "group" {
  for_each = var.GROUPS
  name     = each.value.name
  users = [
    for user in each.value.users :
    authentik_user.user[user].id
  ]
}

## Applications

resource "authentik_application" "app" {
  for_each          = var.APPLICATIONS
  name              = each.value.name
  slug              = each.key
  protocol_provider = authentik_provider_proxy.provider[each.key].id
}


resource "authentik_provider_proxy" "provider" {
  for_each              = var.APPLICATIONS
  name                  = "${each.key}Provider"
  access_token_validity = "hours=24"
  authorization_flow    = authentik_flow.authorization_implicit.uuid
  invalidation_flow     = authentik_flow.invalidation_flow.uuid
  external_host         = "https://${each.key}.${var.DOMAIN}"
  mode                  = "forward_single"
  property_mappings = [
    authentik_property_mapping_provider_scope.remote_fields.id
  ]
}

resource "authentik_policy_binding" "binding" {
  for_each = var.APPLICATIONS
  target   = authentik_application.app[each.key].uuid
  group    = authentik_group.group[each.value.group].id
  order    = 0
}

resource "authentik_outpost" "outpost" {
  name = "authentik Embedded Outpost"
  protocol_providers = concat(
    [
      for key, value in var.APPLICATIONS :
      authentik_provider_proxy.provider[key].id
    ],
    [authentik_provider_oauth2.immichProvider.id]
  )
}

resource "authentik_application" "immich" {
  name              = "Immich"
  slug              = "immich"
  protocol_provider = authentik_provider_oauth2.immichProvider.id
}

resource "authentik_provider_oauth2" "immichProvider" {
  name               = "Immich"
  client_id          = "immich"
  authorization_flow = authentik_flow.authorization_implicit.uuid
  invalidation_flow  = authentik_flow.invalidation_flow.uuid
  allowed_redirect_uris = [
    {
      matching_mode = "strict",
      url           = "app.immich:///oauth-callback",
    },
    {
      matching_mode = "strict",
      url           = "https://immich.${var.DOMAIN}/auth/login",
    },
    {
      matching_mode = "strict",
      url           = "https://immich.${var.DOMAIN}/user-settings",
    }
  ]
}