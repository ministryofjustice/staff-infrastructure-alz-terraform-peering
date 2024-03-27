# ALZ Peering

This module creates a peering connection between the two specified VNETs

This module allows the creation of a source peer only, e.g. if we don't have full access to the target peer. This is controlled by the create_target_peering variable, which defaults to true.

Finally this module requires that the providers are passed in explicitly. This is necessary to allow the use of for_each in the calling code, which as we are potentially using two subscriptions we can't rely on inheritance to get the right provider.

**Note for Cross-Tenant Peerings**

Setting up a cross-tenant peer is also possible using this module. However certain pre-requisities have to be taken care of

- Ensure that the SP from source tenant which will create the one-way peering is set to multitenant.
- Secondly ensure it has www.microsoft.com as a redirect URI
- Grant this SP (app) from tenant 1 access to tenant 2 using the following url. Substitute the values as required.
  <https://login.microsoftonline.com/> Tenant2 ID>/oauth2/authorize?client_id=<Application 1 (client) ID>&response_type=code&redirect_uri=https%3A%2F%2Fwww.microsoft.com%2F
- Autorize this app in tenant 2 as you open the above url.
- With successful authorization the tenant 1 sp will be visible in tenant 2 as an Enterprise App.
- Now go the 2nd tenant and grant Network Contributor RBAC role on the vnet (which with peering is desired) to the tenant 1 sp .
- In tenant 1 terraform versions file modify the provider config for the spoke (or hub) whichever is source peer and add the auxillary tenant id attibute as

```
provider "azurerm" {
    alias = "spoke"
    features {}
    tenant_id       = var.tenant_id # this is tenant 1 id
    subscription_id = var.subscription_id #tenant 1 sub id
    auxiliary_tenant_ids = ["var.tenant_2_id"] # tenant 2 id
}
```

- Ensure you pass this provider to the source peer module when calling alz-peering module.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm.source"></a> [azurerm.source](#provider\_azurerm.source) | n/a |
| <a name="provider_azurerm.target"></a> [azurerm.target](#provider\_azurerm.target) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_network_peering.peer_from_source](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |
| [azurerm_virtual_network_peering.peer_from_target](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_target_peering"></a> [create\_target\_peering](#input\_create\_target\_peering) | This control whether the target peering is created. This could be useful for creating peers with 3rd parties | `bool` | `true` | no |
| <a name="input_forward_traffic_enable"></a> [forward\_traffic\_enable](#input\_forward\_traffic\_enable) | Controls if forwarded traffic from VMs in the remote virtual network is allowed. Defaults to false. | `bool` | `true` | no |
| <a name="input_peering_name_source"></a> [peering\_name\_source](#input\_peering\_name\_source) | Name of source peering | `any` | n/a | yes |
| <a name="input_peering_name_target"></a> [peering\_name\_target](#input\_peering\_name\_target) | Name of target peering | `any` | n/a | yes |
| <a name="input_resource_group_source"></a> [resource\_group\_source](#input\_resource\_group\_source) | Resource Group Name containing Source resources | `any` | n/a | yes |
| <a name="input_resource_group_target"></a> [resource\_group\_target](#input\_resource\_group\_target) | Resource Group Name containing Target resources | `any` | n/a | yes |
| <a name="input_vnet_gateway_enable"></a> [vnet\_gateway\_enable](#input\_vnet\_gateway\_enable) | Flag to control if traffic can flow through VNET gateway. Set to true if traffic is allowed to flow through gateway | `bool` | `false` | no |
| <a name="input_vnet_id_source"></a> [vnet\_id\_source](#input\_vnet\_id\_source) | ID of source Virtual Network | `any` | n/a | yes |
| <a name="input_vnet_id_target"></a> [vnet\_id\_target](#input\_vnet\_id\_target) | ID of target Virtual Network | `any` | n/a | yes |
| <a name="input_vnet_name_source"></a> [vnet\_name\_source](#input\_vnet\_name\_source) | Name of source Virtual Network | `any` | n/a | yes |
| <a name="input_vnet_name_target"></a> [vnet\_name\_target](#input\_vnet\_name\_target) | Name of target Virtual Network | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->