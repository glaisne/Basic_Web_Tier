variable "tenant_id" {
    type = string
    description = "Tenant ID"
}

variable "subscription_id" {
    type = string
    description = "Subscription ID"
}

variable "resource_group_name" {
    type = string
    description = "Name of the Resource Group Name"
    default = "rg-terraform_project"
}

variable "location" {
    type = string
    description = "Location (or region) for the Azure resources"
    default = "eastus2"
}

variable "vnet_name" {
    type = string
    description = "Name for a Virtual Network"
    default = "vnet"
}

variable "vnet_address_space" {
    type = list
    description = "List of IP Address Space CIDRs for a Virtual Network"
    default = [
        "10.0.0.0/16"
    ]
}

variable "source_address_space" {
    type = string
    description = "IPv4 address that is allowed access to web application"
    default = "10.10.10.10/32"
}

# variable "public_certificate_path" {
#     type = string
#     description = "Path to the public certificate file"
#     default = "${path.module}/certificate/cert.pem"
# }