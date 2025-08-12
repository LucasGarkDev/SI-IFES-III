terraform {
  required_version = ">= 1.0"
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

# Provider do VirtualBox (não requer config extra)
provider "virtualbox" {}

############################
# PARÂMETROS EDITÁVEIS
############################
# Quantidade de nós (VMs)
variable "nodes" {
  type    = number
  default = 4
}

# Nome lógico da rede interna (apenas documentação).
locals {
  internal_network_name = "rede01" # informativo
}

# Recursos: VMs idênticas, conectadas à rede "internal"
resource "virtualbox_vm" "node" {
  count  = var.nodes
  name   = format("node-%02d", count.index + 1)
  image = "https://app.vagrantup.com/bento/boxes/ubuntu-20.04/versions/202401.25.0/providers/virtualbox.box"
  cpus   = 1
  memory = "1024 mib"

  
  network_adapter {
    type = "internal"
  }
}

# Sem outputs de IP porque em "internal" não há DHCP automático.

