terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "~> 3.2.4"
    }
  }
}

resource "null_resource" "start_vm" {
  provisioner "local-exec" {
    command = "vagrant up"
  }
}
