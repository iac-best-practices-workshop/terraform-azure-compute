variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "location" {
  description = "Azure region in which to deploy resources"
  type        = string
}

variable "hostname" {
  description = "computer hostname"
  type        = string
}

variable "admin_password" {
  description = "the admin password"
  type        = string
}
