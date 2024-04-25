locals {
  subname = "pr"

  subnet = {
    "snet-pr-alz-peering-001" = {
      address_prefixes                          = ["192.168.1.0/28"]
      private_endpoint_network_policies_enabled = true
      delegations                               = []
      service_endpoints                         = ["Microsoft.Storage", "Microsoft.KeyVault"]
    }
  }
}
resource "azurerm_resource_group" "rg" {
  name     = "rg-pr-alzpeering-001"
  location = "UK South"
  tags     = var.tags
}

module "vnet" {
  source              = "github.com/ministryofjustice/staff-infrastructure-alz-terraform-vnet//modules/alz-vnet?ref=v1.0.0"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet              = local.subnet
  tags                = var.tags
  vnet_name           = "vnet-pr-alz-peering-001"
  vnet_address_space  = var.vnet_address_space
}

module "source-peering" {
  source                = "../../..//modules/version1.0.0/alz-peering"
  create_target_peering = false
  peering_name_source   = "Peering-Test"
  peering_name_target   = "monitoring"
  resource_group_source = azurerm_resource_group.rg.name
  resource_group_target = "rg-hub-internal-001"
  vnet_name_source      = "vnet-pr-alz-peering-001"
  vnet_name_target      = "vnet-hub-monitoring-dev"
  vnet_id_source        = module.vnet.vnet_id
  vnet_id_target        = "/subscriptions/c5551d23-f465-4e90-9f4d-ef19eecff6a0/resourceGroups/rg-hub-internal-001/providers/Microsoft.Network/virtualNetworks/vnet-hub-monitoring-dev"
  # VNETGateway flag to control if traffic can flow through VNET gateway. Set to true if traffic is allowed to flow through gateway
  vnet_gateway_enable    = false
  forward_traffic_enable = false
  providers = {
    azurerm.source = azurerm
    azurerm.target = azurerm
  }
  #I don't understand why this is required
  depends_on = [
    module.vnet
  ]
}
