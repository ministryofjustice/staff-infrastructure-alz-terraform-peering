<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >=1.5.7  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement_azurerm)       | >=3.33.0 |

## Providers

| Name                                                         | Version  |
| ------------------------------------------------------------ | -------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | >=3.33.0 |

## Modules

| Name                                                                          | Source                                                                                 | Version |
| ----------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- | ------- |
| <a name="module_source-peering"></a> [source-peering](#module_source-peering) | ../../..//modules/version1.0.0/alz-peering                                             | n/a     |
| <a name="module_vnet"></a> [vnet](#module_vnet)                               | github.com/ministryofjustice/staff-infrastructure-alz-terraform-vnet//modules/alz-vnet | v1.0.0  |

## Resources

| Name                                                                                                                        | Type     |
| --------------------------------------------------------------------------------------------------------------------------- | -------- |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name                                                                                    | Description                                   | Type                                                                                                                                                                                                                                                                                                                 | Default                                                                                                                                                                                                                                                                   | Required |
| --------------------------------------------------------------------------------------- | --------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_environment"></a> [environment](#input_environment)                      | The spoke name                                | `string`                                                                                                                                                                                                                                                                                                             | `"pr"`                                                                                                                                                                                                                                                                    |    no    |
| <a name="input_subnet"></a> [subnet](#input_subnet)                                     | This variable contains the subnet details     | <pre>map(object({<br> address_prefixes = list(string)<br> enforce_private_link_endpoint_network_policies = bool<br> service_endpoints = list(string)<br> delegations = list(object({<br> name = string<br> service_delegation = list(object({<br> name = string<br> actions = list(string) }))<br> }))<br> }))</pre> | <pre>{<br> "testsubnet1": {<br> "address_prefixes": [<br> "192.168.1.0/28"<br> ],<br> "delegations": [],<br> "enforce_private_link_endpoint_network_policies": false,<br> "service_endpoints": [<br> "Microsoft.Storage",<br> "Microsoft.KeyVault"<br> ]<br> }<br>}</pre> |    no    |
| <a name="input_subscription_id"></a> [subscription_id](#input_subscription_id)          | subscription id                               | `string`                                                                                                                                                                                                                                                                                                             | `"4b068872-d9f3-41bc-9c34-ffac17cf96d6"`                                                                                                                                                                                                                                  |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                           | Standard tags for supported resources         | `map(string)`                                                                                                                                                                                                                                                                                                        | `{}`                                                                                                                                                                                                                                                                      |    no    |
| <a name="input_tenant_id"></a> [tenant_id](#input_tenant_id)                            | Tenant id                                     | `string`                                                                                                                                                                                                                                                                                                             | `"0bb413d7-160d-4839-868a-f3d46537f6af"`                                                                                                                                                                                                                                  |    no    |
| <a name="input_vnet_address_space"></a> [vnet_address_space](#input_vnet_address_space) | The virtual network allocated address spaces. | `list(string)`                                                                                                                                                                                                                                                                                                       | <pre>[<br> "192.168.1.0/24"<br>]</pre>                                                                                                                                                                                                                                    |    no    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
