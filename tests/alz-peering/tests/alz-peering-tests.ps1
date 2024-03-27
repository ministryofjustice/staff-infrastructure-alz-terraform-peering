Describe 'Vnet Validation' {
    #We're repeating a lot of the testing code, so will add a JIRA to look at how we can do this better, e.g. is it possible to have a testing module that we load?
    BeforeAll {
        $testSubscriptionId = "4b068872-d9f3-41bc-9c34-ffac17cf96d6"
        az account set --subscription $testSubscriptionId
        $rg ="rg-pr-alzpeering-001"
        $vnetName = "vnet-pr-alz-peering-001"
        $addressSpace = @( "192.168.1.0/24")
        $testSubscriptionId = "4b068872-d9f3-41bc-9c34-ffac17cf96d6"
        $subnetServiceEndpoints = @{
            name             = "snet-pr-alz-peering-001"
            addressPrefixes  = @("192.168.1.0/28")
            serviceEndpoints = @(
                @{name = "Microsoft.Storage"; provisioningState = "Succeeded" },
                @{name = "Microsoft.KeyVault"; provisioningState = "Succeeded" })
        }
        $sutVnet = (az network vnet show -n $vnetName -g $rg -o json | ConvertFrom-Json)
        $sutSubnetServiceEndpoints = (az network vnet subnet show -n $subnetServiceEndpoints['name'] --vnet-name $vnetName -g $rg -o json | ConvertFrom-Json)
        $sourcepeering = (az network vnet peering show --resource-group $rg --vnet-name $vnetName --name "peer-Peering-Test-to-monitoring" | ConvertFrom-Json)
    }
    Context 'Vnet validation' {
        It "Vnet in correct resource group" { $sutVnet.resourceGroup | Should -Be $rg }
        It "Vnet name is correct" { $sutVnet.name | Should -Be $vnetName }
        It "Vnet is provisioned" { $sutVnet.provisioningState | Should -Be "Succeeded" }
        It "Vnet has correct address space" { Compare-Object -ReferenceObject $sutVnet.addressSpace.addressPrefixes -DifferenceObject $addressSpace | Should -Be $null }
        It "Vnet has four subnet" { $sutVnet.subnets.Length | Should -Be 1 }
    }
    Context "Subnet With Service Endpoints Validation" {
        It "Subnet is in correct vnet" { $sutVnet.subnets.name -contains $subnetServiceEndpoints['name']  | Should -Be $true }
        It "Subnet in correct resource group" { $sutSubnetServiceEndpoints.resourceGroup | Should -Be $rg }
        It "Subnet name is correct" { $sutSubnetServiceEndpoints.name | Should -Be $subnetServiceEndpoints['name'] }
        It "Subnet is provisioned" { $sutSubnetServiceEndpoints.provisioningState | Should -Be "Succeeded" }
        It "Subnet has correct address space" { Compare-Object -ReferenceObject $sutSubnetServiceEndpoints.addressPrefix -DifferenceObject $subnetServiceEndpoints['addressPrefixes'] | Should -Be $null }
        It "Subnet has correct endpoints" { Compare-Object -ReferenceObject $sutSubnetServiceEndpoints.serviceEndpoints.service -DifferenceObject $subnetServiceEndpoints['serviceEndpoints'].name | Should -Be $null }
        It "Subnet has endpoints provisioned" { Compare-Object -ReferenceObject $sutSubnetServiceEndpoints.serviceEndpoints.provisioningState -DifferenceObject $subnetServiceEndpoints['serviceEndpoints'].provisioningState | Should -Be $null }
    }
    Context 'Peering validation' {
        ## test scenarios to validate the peering
        It "Source Peering in correct resource group" { $sourcepeering.resourceGroup | Should -Be $rg }
        It "Source Peering name is correct" { $sourcepeering.name | Should -Be "peer-Peering-Test-to-monitoring" }
        It "Source Peering subscription is correct" { $sourcepeering.id.split('/')[2] | Should -Be $testSubscriptionId }
        It "Source peering is provisioned" { $sourcepeering.provisioningState | Should -Be "Succeeded" }
        It "Source peering is connected" { $sourcepeering.peeringState | Should -Be "Initiated" }   #This is because we're only doing one side of the peering, so the other side is not connected yet
        It "Source peering is attached to correct VNET" { $sourcepeering.id.split('/')[8] | Should -Be $vnetName }
        It "Source peering does not allow forwarding of traffic" { $sourcepeering.allowForwardedTraffic | Should -Be "False" }
        It "Source peering does not allow Gateway Transit" { $sourcepeering.allowGatewayTransit | Should -Be "False" }
    }
}
