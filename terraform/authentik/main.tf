variable "DOMAIN" {
  description = "The domain the apps should use for subdomains"
}

variable "USER1" {
  description = "User 1 Info"
}

variable "USER2" {
  description = "User 1 Info"
}

variable "IMPORTS" {
  description = "IDs for Import statements"
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

import {
  id = var.IMPORTS.mappings.remote-fields
  to = authentik_property_mapping_provider_scope.remote_fields
}

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

import {
  id = var.IMPORTS.users.user1
  to = authentik_user.user1
}

resource "authentik_user" "user1" {
  username = var.USER1.username
  email    = var.USER1.email
  name = var.USER1.name
  attributes = jsonencode({
    settings = {
        locale = "de"
    }
  })
}

import {
  id = var.IMPORTS.users.user2
  to = authentik_user.user2
}

resource "authentik_user" "user2" {
  username = var.USER2.username
  email    = var.USER2.email
  name = var.USER2.name
  attributes = jsonencode({
    settings = {
        locale = "de"
    }
  })
}

## Groups

import {
  id = var.IMPORTS.groups.admins
  to = authentik_group.admins
}

resource "authentik_group" "admins" {
  name = "Admins"
  users = [
    authentik_user.user1.id
  ]
}

import {
  id = var.IMPORTS.groups.parents
  to = authentik_group.parents
}

resource "authentik_group" "parents" {
  name = "Parents"
  users = [
    authentik_user.user1.id,
    authentik_user.user2.id
  ]
}

## Applications

# ASF

import {
  id = "asf"
  to = authentik_application.asf
}

resource "authentik_application" "asf" {
  name              = "ASF"
  slug              = "asf"
  protocol_provider = authentik_provider_proxy.asfprovider.id
}

import {
  id = var.IMPORTS.applications.asf.provider
  to = authentik_provider_proxy.asfprovider
}

resource "authentik_provider_proxy" "asfprovider" {
  name                   = "ASFProvider"
  access_token_validity  = "hours=24"
  authorization_flow     = authentik_flow.authorization_implicit.uuid
  invalidation_flow      = authentik_flow.invalidation_flow.uuid
  external_host          = "https://asf.${var.DOMAIN}"
  mode                   = "forward_single"
  property_mappings = [
    authentik_property_mapping_provider_scope.remote_fields.id
  ]
}