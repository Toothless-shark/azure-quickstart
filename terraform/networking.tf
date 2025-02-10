# Create network interface
resource "azurerm_network_interface" "nic1" {
  name                = "${random_pet.prefix.id}-nic1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = azurerm_subnet.my_terraform_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}