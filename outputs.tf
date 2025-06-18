output "web01_public_ip" {
    value = resource.azurerm_public_ip.pip-web01.ip_address
    description = "Public IP address of the web server VM"
}

