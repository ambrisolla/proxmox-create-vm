terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
    }
  }
}

provider "proxmox" {
  pm_api_url  = var.proxmox_host
}

resource "proxmox_vm_qemu" "resource-name" {
  name        = var.hostname
  target_node = var.target_node
  clone       = var.clone
  memory      = var.memory
  cores       = var.cores
  scsihw      = "virtio-scsi-single"
  
  connection {
    type        = "ssh"
    host        = var.template_ip
    user        = var.ssh_user
    password    = var.ssh_password
    #private_key = file("/home/andre/.ssh/id_rsa")
    port        = "22"
  }

  provisioner "file" {
    source      = "./scripts/02-post-install.sh"
    destination = "/tmp/02-post-install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname  ${var.hostname}",
      "chmod +x /tmp/02-post-install.sh",
      "sudo /tmp/02-post-install.sh ${var.ipaddr} ${var.netmask} ${var.gateway} ${var.salt_master}"
      ]
  }

}
