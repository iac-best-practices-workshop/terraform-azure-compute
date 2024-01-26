output "virtual_machine_name" {
  description = "Name of the created virtual machine"
  value       = azurerm_virtual_machine.example.name
}

output "virtual_machine_id" {
  description = "ID of the created virtual machine"
  value       = azurerm_virtual_machine.example.id
}
