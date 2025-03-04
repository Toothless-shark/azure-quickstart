variable "public_key_loc" {
  default = "/home/shark/Desktop/1/terraform-azure-quickstart/terraform/id_rsa.pub"
}

variable "resource_group_location" {
  type        = string
  default     = "francecentral"
  description = "Location of the resource group"
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "toothless"
  description = "Prefix of the resource group name that's combined with a random ID"
}

variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}
