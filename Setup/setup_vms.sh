modprobe vfio-pci
echo "19ee 6003" > /sys/bus/pci/drivers/vfio-pci/new_id
chmod 777 modify_vm_xml.sh
. modify_vm_xml.sh
get_VF_bus 0 2
bind_VF_to_passthrough_driver
add_VF_to_VM_xml vm1.xml
get_VF_bus 0 3
bind_VF_to_passthrough_driver
add_VF_to_VM_xml vm2.xml
