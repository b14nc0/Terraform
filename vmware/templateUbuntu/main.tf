provider "vsphere" {
  user           = ""
  password       = ""
  vsphere_server = ""
# If you have a self-signed cert
  allow_unverified_ssl = true
}
data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
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


resource "vsphere_virtual_machine" "templateUbuntu" {
  name             = "MVPRUEBATERRAFORM"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = "Pruebas"
  num_cpus = 2
  memory   = 1024
  guest_id = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    size  = 20
    thin_provisioned = data.vsphere_virtual_machine.source_template.disks[0].thin_provisioned
  }
}
