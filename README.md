# Files and instructions for "Open vSwitch and Agilio OVS" lab
---

This package contains scripts and instructions to run the Open vSwitch and
Agilio OVS lab that was carried out at the Open-NFP Developer Day on the
10th of November 2016.


## Prerequisites


This lab assumes that the Agilio OVS Firewall tarball is extracted on the
system and an Agilio SmartNIC is installed.

To complete lab1, a wired connection to one of the physical ports will be
required. Lab2 and lab3 will run off VMs booted on the host.

Follow the steps in the Agilio Getting Started and User Guides to set.

For convenience you can use the following scripts and steps:

- Ensure that KVM and Virt-manager are installed on the system:

    **sudo apt-get install kvm virt-manager**

- Enter the 'init' folder located in this repo and run the following 2 scripts:

    **./update_apparmor.sh**
    
    **./update_grub.sh**

- Install dependencies for Agilio OVS:

    **apt-get -y install make autoconf automake libtool \
 gcc g++ bison flex hwloc-nox libreadline-dev libpcap-dev dkms libftdi1 \
 libjansson4 libjansson-dev guilt pkg-config libevent-dev ethtool libssl-dev \
 libnl-3-200 libnl-3-dev libnl-genl-3-200 libnl-genl-3-dev psmisc gawk \
 libzmq3-dev protobuf-c-compiler protobuf-compiler python-protobuf**

- Move to the extracted Agilio OVS folder and install it in firewall mode:

    **make clean_install_firewall**

- Create 2 VMs (we use qcow2 format) and copy them to /var/lib/libvirt/images/
under the names dxdd_vm.qcow2 and dxdd_vm2.qcow2. If you use different names or
formats then the xml template files in the 'lab setup' section will need
updated.

- Reboot the system

The above steps only need to be run once on each system used for the lab.


##Lab Setup


These steps are required after each reboot to run the lab.

- Start Agilio OVS Firewall as root

    **/opt/netronome/bin/ovs-ctl --nfp-reset restart --delete-bridges**

- Enter the 'setup' folder in this repo and initialise the VM xml:

    **./setup_vms.sh**

- launch the VMs

    **./start_vms.sh**

- verify the VMs are running with:

    **virsh list**


##VM Configuration


If the VM in use is not already installed with Netronome drivers then the
guest must be configured as follows (installation packages are available from
the Netronome support site):

- On Debian run the following:

    **dpkg --install nfp-bsp-release-2015.11-dkms_2016.7.13.1116-1_all.deb \
netronome-dpdk_16.04-0000_amd64.deb nfp-uio-dkms_0.0.1_amd64.deb**

- On RHEL/CentOS:

    **yum install agilio-ovs-common-2.2-1.el7.centos.x86_64.rpm \
openvswitch-dkms-2.5.1-1.el7.centos.x86_64.rpm \
agilio-ovs-dpdk1604-2.2-1.el7.centos.x86_64.rpm**

- Alternatively copy over the Agilio tarball, extract and run:

    **make vm_install**

If there are any issues with these steps, please refer to the Agilio OVS
Getting Started Guide and/or User Guide.


###Lab0

Lab0 is required to be run before any other labs as it configures the ports on
the system.

- Enter the lab0 directory and run:

    **./configure_ovs.sh**

- Alternatively follow the instructions and explanations in lab0.txt


###Lab1

Lab1 adds rules to send traffic from a physical port to a VM.

- Enter the lab1 directory and run:

    **./phy_to_vm.sh**

- Then replay UDP traffic from a system connected to physical port 1 on the
Agilio SmartNIC

- Alternatively follow the instructions and explanations in lab1.txt


###Lab2

Lab2 sets up a ping between VM1 and VM2.

- Enter the lab2 directory and run:

    **./vm_to_vm.sh**

- Configure the IP addresses on the VF interface on both VMs (see lab2.txt)

- Ping between VMs

- Alternatively follow the instructions and explanations in lab2.txt


###Lab3

Lab3 implements a simple stateful firewall to block/permit pings in one
direction.

- Enter the lab3 directory and run:

    **./stateful_firewall.sh**

- Configure the IP addresses on VF interface on VMs (if not done in lab2)

- Ping in either direction on the VMs

- Alternatively follow the instructions and explanations in lab3.txt

