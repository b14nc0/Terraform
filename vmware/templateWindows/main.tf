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
    #customize {
    #  windows_options {
    #    computer_name  = "Web1"
    #    workgroup      = "home"
    #    admin_password = "__LocalAdmin__"
    #  }
    #  network_interface {
    #    ipv4_address = "192.168.0.46"
    #    ipv4_netmask = 24
    #  }
    #  ipv4_gateway = "192.168.0.1"
    # }
  }
}
