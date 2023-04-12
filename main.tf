terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
    }
  }
}

provider "proxmox" {
  pm_api_url  = var.proxmox_host
  pm_user     = var.proxmox_user
  pm_password = var.proxmox_password
}

resource "proxmox_vm_qemu" "resource-name" {
  name        = var.hostname
  target_node = var.target_node
  clone       = var.clone
  memory      = var.memory
  vcpus       = var.vcpus
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
    source      = "./scripts/post-install.sh"
    destination = "/tmp/post-install.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname  ${var.hostname}",
      "chmod +x /tmp/post-install.sh",
      "sudo /tmp/post-install.sh ${var.ipaddr} ${var.netmask} ${var.gateway} ${var.salt_master}"
      ]
  }

}
