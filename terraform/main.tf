// -------------------------------------------------------------
// TERRAFORM
// -------------------------------------------------------------
terraform {
  required_providers {
    fakewebservices = {
      source  = "hashicorp/fakewebservices"
      version = "0.2.3"
    }
  }
}

// -------------------------------------------------------------
// PROVIDERS
// -------------------------------------------------------------
provider "fakewebservices" {
  hostname = var.fws_hostname
  token    = var.fake_token
}

// -------------------------------------------------------------
// VARIABLES
// -------------------------------------------------------------
variable "fws_hostname" {
  type        = string
  description = "The Terraform Cloud/Enterprise hostname that will be used in the provider configuration block."
}

variable "fake_token" {
  type        = string
  sensitive   = true
  description = "The Terraform Cloud/Enterprise user/team token that will be used in the provider configuration block."
}

variable "server_count" {
  description = "The number of fakewebservices_server resources that will get provisioned."
}

// -------------------------------------------------------------
// MODULE
// -------------------------------------------------------------
module "stack" {
  source         = "aqitio/stack/fakewebservices"
  version        = "0.0.6"
  stack_prefix   = "PRD"
  server_count   = 5
  server_type    = "t2.micro"
  database_size  = 256
  vpc_cidr_block = "0.0.0.0/1"
}