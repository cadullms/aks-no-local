resource "azurerm_resource_group" "aksnolocal_rg" {
  name     = "aksnolocal_rg"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "example" {

  name                = "aksnolocal"
  location            = azurerm_resource_group.aksnolocal_rg.location
  resource_group_name = azurerm_resource_group.aksnolocal_rg.name
  dns_prefix          = "cadullnolocal"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed                = true
      azure_rbac_enabled     = true
      admin_group_object_ids = [var.admin_group_object_ids]
    }
  }

  local_account_disabled = true

}
