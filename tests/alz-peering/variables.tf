variable "environment" {
  default     = "pr"
  description = "The spoke name"
}

variable "tenant_id" {
  default     = "0bb413d7-160d-4839-868a-f3d46537f6af"
  description = "Tenant id"
}

variable "subscription_id" {
  default     = "4b068872-d9f3-41bc-9c34-ffac17cf96d6"
  description = "subscription id"
}

variable "subnet" {
  description = "This variable contains the subnet details"

  type = map(object({
    address_prefixes                               = list(string)
    enforce_private_link_endpoint_network_policies = bool
    service_endpoints                              = list(string)
    delegations = list(object({
      name = string
      service_delegation = list(object({
        name = string
      actions = list(string) }))
    }))
  }))

  default = {
    "testsubnet1" = {
      address_prefixes                               = ["192.168.1.0/28"]
      enforce_private_link_endpoint_network_policies = false
      service_endpoints                              = ["Microsoft.Storage", "Microsoft.KeyVault"]
      delegations                                    = []
    },

  }
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Standard tags for supported resources"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The virtual network allocated address spaces."
  default     = ["192.168.1.0/24"]
}
