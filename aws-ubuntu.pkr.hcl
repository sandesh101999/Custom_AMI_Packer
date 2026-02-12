packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "2.3.3"
    }
  }
}

source "azure-arm" "ubuntu" {

  # -------- AUTH (from GitHub env vars) ----------
  client_id       = env("ARM_CLIENT_ID")
  client_secret   = env("ARM_CLIENT_SECRET")
  subscription_id = env("ARM_SUBSCRIPTION_ID")
  tenant_id       = env("ARM_TENANT_ID")

  # -------- IMAGE OUTPUT ----------
  managed_image_name                = "learn-packer-ubuntu-image"
  managed_image_resource_group_name = "packer-image-rg"

  # -------- BUILD SETTINGS ----------
  build_resource_group_name = "packer-build-rg"
  location                  = "Central India"
  vm_size                   = "Standard_B1s"

  # -------- SOURCE IMAGE ----------
  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts"
  image_version   = "latest"

  # -------- SSH ----------
  communicator = "ssh"
  ssh_username = "azureuser"

  azure_tags = {
    environment = "dev"
    created_by  = "packer"
  }
}

build {
  name = "learn-packer-azure"

  sources = [
    "source.azure-arm.ubuntu"
  ]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]
  }
}
