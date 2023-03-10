vsphere_datacenter                  = "My Datacenter"
vsphere_datastore                   = "My Datastore"
vsphere_resource_pool               = "My Cluster/"  // If no Resource Pool is present, use vSphere Cluster
network_cards                       = ["VM Network"] // vSwith/DVS Port Group
vsphere_folder                      = "Prueba"  // Use the following format for nested folders: "Folder1/Folder2/Folder3"
vsphere_vm_template_name            = "VM Templates/windows-TMP"
vsphere_virtual_machine_name        = "Arc-windows-Demo"
vsphere_virtual_machine_count       = 1
vsphere_virtual_machine_cpu_count   = "2"
vsphere_virtual_machine_memory_size = "4096" //Megabytes
cpu_hot_add_enabled                 = true
cpu_hot_remove_enabled              = true
memory_hot_add_enabled              = true
domain                              = "something.local"
virtual_machine_network_address     = "10.0.0.0/24"
virtual_machine_ip_address_start    = "61" // VM will be assigned with 10.0.0.61
ipv4_submask                        = ["24"]
vm_gateway                          = "10.0.0.1" // Your gateway address
vm_dns = [                                       // Your DNS server address
  "10.0.0.1",
]
