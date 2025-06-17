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