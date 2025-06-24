## 🟡 **Basic Web Tier**

**Goal**: Create a simple, secure virtual network and deploy a Linux web server.

### Requirements:

* A VNet with a subnet and an NSG attached.
* A public IP and NIC.
* A Linux VM with cloud-init to install NGINX.
* Open port 80 only to a specific IP range.
* Output the VM public IP.

**Azure Resources**:

* `azurerm_virtual_network`
* `azurerm_subnet`
* `azurerm_network_security_group`
* `azurerm_network_interface`
* `azurerm_linux_virtual_machine`
* `azurerm_public_ip`

**Terraform Concepts**:

* Dependencies
* Provisioners
* Security best practices