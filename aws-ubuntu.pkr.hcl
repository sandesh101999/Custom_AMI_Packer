 packer {
  required_plugins {
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "2.3.3"
    }
  }
}

source "azure-arm" "ubuntu" {

  managed_image_name                = "learn-packer-ubuntu-image"
  managed_image_resource_group_name = "packer-image-rg"

  location = "Central India"
  vm_size  = "Standard_B1s"

  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "0001-com-ubuntu-server-jammy"
  image_sku       = "22_04-lts"
  image_version   = "latest"

  communicator = "ssh"
  ssh_username = "azureuser"
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
