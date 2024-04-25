variable "create_target_peering" {
  type        = bool
  description = "This control whether the target peering is created. This could be useful for creating peers with 3rd parties"
  default     = true
}

variable "peering_name_source" {
  description = "Name of source peering"
}

variable "peering_name_target" {
  description = "Name of target peering"
}

variable "resource_group_source" {
  description = "Resource Group Name containing Source resources"
}

variable "resource_group_target" {
  description = "Resource Group Name containing Target resources"
}

variable "vnet_name_source" {
  description = "Name of source Virtual Network"
}

variable "vnet_name_target" {
  description = "Name of target Virtual Network"
}

variable "vnet_id_source" {
  description = "ID of source Virtual Network"
}

variable "vnet_id_target" {
  description = "ID of target Virtual Network"
}


variable "vnet_gateway_enable" {
  type        = bool
  description = "Flag to control if traffic can flow through VNET gateway. Set to true if traffic is allowed to flow through gateway"
  default     = false
}

variable "forward_traffic_enable" {
  type        = bool
  description = "Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false."
  default     = true
}

