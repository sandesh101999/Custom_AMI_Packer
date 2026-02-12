packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = ">= 1.4.0"
    }
  }
}

source "azure-arm" "ubuntu" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  managed_image_resource_group_name = "packer-image-rg"
  managed_image_name                = "learn-packer-ubuntu"

  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts"

  location = "Central India"
  vm_size  = "Standard_D2s_v3"

  azure_tags = {
    environment = "dev"
    created_by  = "packer"
  }
}

build {
  name    = "azure-ubuntu-build"
  sources = ["source.azure-arm.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx"
    ]
  }
}

variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {
  sensitive = true
}
variable "tenant_id" {}
