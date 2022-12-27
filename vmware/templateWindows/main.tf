provider "vsphere" {
  user           = ""
  password       = ""
  vsphere_server = ""
# If you have a self-signed cert
  allow_unverified_ssl = true
}
data "vsphere_datacenter" "dc" {
  name = ""
}
data "vsphere_datastore" "datastore" {
  name          = ""
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
  name          = ""
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_virtual_machine" "source_template" {
  name          = "" 
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = ""
  datacenter_id = data.vsphere_datacenter.dc.id
}


resource "vsphere_virtual_machine" "vm" {
  name             = "MVPRUEBATERRAFORM"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = "Pruebas"
  num_cpus = 4 
  memory   = 4096
  guest_id = "windows9Server64Guest" 
  cpu_hot_add_enabled    = true 
  memory_hot_add_enabled = true
  scsi_type = data.vsphere_virtual_machine.source_template.scsi_type
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    #size  = data.vsphere_virtual_machine.source_template.disks.0.size
    size  = 200 
    thin_provisioned = data.vsphere_virtual_machine.source_template.disks[0].thin_provisioned
  }
   clone {
    template_uuid = data.vsphere_virtual_machine.source_template.id
    customize {
      windows_options {
        computer_name  = var.vsphere_virtual_machine_name
        admin_password = var.admin_password
      }
      network_interface {}
      dns_server_list = var.vm_dns
      ipv4_gateway    = var.vm_gateway
   }
  }
# provisioner "file" {
#    source      = "scripts/vars.sh"
#    destination = "C:/vars.sh"

#   connection {
#      type     = "winrm"
#      host     = self.default_ip_address
#      user     = var.admin_user
#      password = var.admin_password
#      https    = false
#      insecure = true
#      timeout  = "5m"
#    }
#  }
#  provisioner "file" {
#    source      = "scripts/install_arc_agent.ps1"
#    destination = "C:/install_arc_agent.ps1"
#
#    connection {
#      type     = "winrm"
#      host     = self.default_ip_address
#      user     = var.admin_user
#      password = var.admin_password
#      https    = false
#      insecure = true
#      timeout  = "5m"
#    }
#  }
#  provisioner "remote-exec" {
#    inline = [
#      "powershell.exe -File C://install_arc_agent.ps1"
#    ]

#    connection {
#      type     = "winrm"
#      host     = self.default_ip_address
#      user     = var.admin_user
#      password = var.admin_password
#      https    = false
#      insecure = true
#      timeout  = "5m"
#    }
#  }
}
