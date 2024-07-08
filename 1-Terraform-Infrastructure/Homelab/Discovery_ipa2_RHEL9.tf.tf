# Proxmox Full-Clone for Ubuntu VM's (Ubuntu 22.04 cloud-init)
# ---
# This will create a new Virtual Machine from a cloud-init file

resource "proxmox_vm_qemu" "ubuntu-vm" {
    
    #Set this number to how many VM's you need to deploy, comment out if you don't need to deploy more than 1 (adjust "vmid" and "name" as needed)
    #count = 1
    # List our target node (this is the node ID of our "cluster")
    # vmid is the virtual machine ID in Proxmox, default starts at 100 and counts up
    # name is the name we will identify our virtual machine as
    # desc is a descriptive name for our virtual machine
    target_node = "discovery"
    vmid = "300"
    name = "ipa2.home.initcyber.net"
    desc = "FreeIPA Server 2"

    # Set VM to start on boot (true/false)
    onboot = true 

    # We are cloning this template identified here - This is a variable identified in credentials.auto.tfvars
    clone = var.rhel_9_template

    # Set to 1 to enable the QEMU Guest Agent.
    agent = 1
    
    # VM CPU settings - self explanatory
    cores = 2
    sockets = 1
    cpu = "host"    
    
    # VM Memory Settings - Again, self explantory
    memory = 4098

    # VM Network Settings - Same
    network {
        bridge = "vmbr0"
        model  = "virtio"
    }

    # Default to cloud-init
    os_type = "cloud-init"

    # IP Address and Gateway - Again, we are using the count.index variable here, assuming we are NOT going above 10 virtual machines this should be OK.
    ipconfig0 = "ip=172.16.10.7/24,gw=172.16.10.1"
    
    # Set user name here
    # ciuser = "your-username"
    # ---
    # Set SSH keys here
    # sshkeys = <<EOF
    # #YOUR-PUBLIC-SSH-KEY
    # EOF
}