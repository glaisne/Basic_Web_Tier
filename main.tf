resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location
}

resource "azurerm_virtual_network" "vnet01" {
    name = var.vnet_name
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    address_space = var.vnet_address_space
}

resource "azurerm_subnet" "vnet01-subnet01" {
    name = "subnet01"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet01.name
    address_prefixes = [ "10.0.1.0/24" ]
}

resource "azurerm_network_security_group" "vnet01-subnet01-nsg" {
    name = "vnet01-subnet01-nsg"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    security_rule {
        name = "Allow-http"
        priority = 1000
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "80"
        source_address_prefix = var.source_address_space
        destination_address_prefix = "*"
    }
}

resource "azurerm_subnet_network_security_group_association" "vnet01-subnet01-nsg-assoc" {
    subnet_id = azurerm_subnet.vnet01-subnet01.id
    network_security_group_id = azurerm_network_security_group.vnet01-subnet01-nsg.id
}

resource azurerm_network_interface "nic-web01" {
    name = "nic-web01"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
        name = "web01-ipconfig"
        subnet_id = azurerm_subnet.vnet01-subnet01.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id = azurerm_public_ip.pip-web01.id
    }
}

resource "azurerm_linux_virtual_machine" "vm-web01" {
    name = "vm-web01"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    size = "Standard_B1s"
    admin_username = "gene"

    network_interface_ids = [
        azurerm_network_interface.nic-web01.id
    ]

    admin_ssh_key {
        username = "gene"
        public_key = file("${path.module}/certificate/certificate.pub")
    }

    os_disk {
        caching = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer = "0001-com-ubuntu-server-jammy"
        sku = "22_04-lts"
        version = "latest"
    }

    custom_data = filebase64("${path.module}/cloud-init_nginx")

}

resource "azurerm_public_ip" "pip-web01" {
    name = "pip-web01"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method = "Static"
}
