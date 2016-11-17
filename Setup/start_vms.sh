virsh net-start default
virsh -c qemu:///session define vm1.xml
virsh -c qemu:///session define vm2.xml
virsh start vm1
virsh start vm2
