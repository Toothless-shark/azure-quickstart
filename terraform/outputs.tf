output "IP_address" {
  description = "IP address of the virtual machine"
  value       = azurerm_linux_virtual_machine.vm1.public_ip_address
}
