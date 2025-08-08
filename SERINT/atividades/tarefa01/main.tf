terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

provider "virtualbox" {}

# Lista de IPs para cada node
locals {
  node_ips = [
    "192.168.100.10",
    "192.168.100.11",
    "192.168.100.12",
    "192.168.100.13"
  ]
}

resource "virtualbox_vm" "node" {
  count     = 4
  name      = format("node-%02d", count.index + 1)

  # Caminho RELATIVO ao .vdi
  image     = "${path.module}/../ubuntu-focal.vdi"
  
  cpus      = 1
  memory    = "1024 mib"

  user_data = templatefile("${path.module}/user_data.tmpl", {
    ip = local.node_ips[count.index]
  })

  network_adapter {
    type           = "intnet"
    host_interface = "rede01"
  }
}

