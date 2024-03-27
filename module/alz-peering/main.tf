# --------------------------------------------------------------------------------------------------------------
# Azure Generic Peering Module
# --------------------------------------------------------------------------------------------------------------

# --------------------------------------------------------------------------------------------------------------
# Resources
# --------------------------------------------------------------------------------------------------------------

# Create peering from Source to Target
resource "azurerm_virtual_network_peering" "peer_from_source" {
  name                      = "peer-${var.peering_name_source}-to-${var.peering_name_target}"
  resource_group_name       = var.resource_group_source
  virtual_network_name      = var.vnet_name_source
  remote_virtual_network_id = var.vnet_id_target
  allow_forwarded_traffic   = var.forward_traffic_enable
  use_remote_gateways       = var.vnet_gateway_enable
  provider                  = azurerm.source
}

# Create peering from Target to Source
resource "azurerm_virtual_network_peering" "peer_from_target" {
  count                     = var.create_target_peering ? 1 : 0
  name                      = "peer-${var.peering_name_target}-to-${var.peering_name_source}"
  resource_group_name       = var.resource_group_target
  virtual_network_name      = var.vnet_name_target
  remote_virtual_network_id = var.vnet_id_source
  allow_forwarded_traffic   = var.forward_traffic_enable
  allow_gateway_transit     = var.vnet_gateway_enable
  provider                  = azurerm.target
}
