# $1 PCIE bus number
# $2 VF number
# returns:
# $__vfpciid contains the VF PCI ID
# $__vfirq contains the VF netdev IRQ (if it is a host netdev)
function get_VF_bus()
{
  local PCIE=$1
  local VF=$2
  local i=$VF
  local regex="^ *([0-9]+).*"
  unset __vfpciid
  unset __vfbus
  unset __vfslot
  unset __vffunction

  local vfpciid=`ethtool -i sdn_v$PCIE.$i|grep bus-info|sed -e "s/^bus-info: NFP 0 VF$PCIE\.$i //"`
  if [ -z $vfpciid ]; then
    klog Could not find VF on $PCIE.$i
    return
  fi
  __vfpciid=$vfpciid

  vf_parts=$(echo $__vfpciid | tr ":" "\n")

  count=0
  for part in $vf_parts
  do
    if [ $count -eq 1 ]
    then
      __vfbus=$part
    fi

    if [ $count -eq 2 ]
    then
      vf_parts2=$(echo $part | tr "." "\n")
      count2=0
      for part2 in $vf_parts2
      do
        if [ $count2 -eq 0 ]
        then
          __vfslot=$part2
        fi

        if [ $count2 -eq 1 ]
        then
          __vffunction=$part2
        fi
        count2=$((count2+1))
      done
      break
    fi

    count=$((count+1))
  done
}

#take the stored bus from previous function and bind this VF to vfio-pci
function bind_VF_to_passthrough_driver()
{
  echo "/opt/netronome/libexec/dpdk_nic_bind.py -b vfio-pci $__vfbus:$__vfslot.$__vffunction"
  /opt/netronome/libexec/dpdk_nic_bind.py -b vfio-pci $__vfbus:$__vfslot.$__vffunction
}

#modifies the input xml file to add the VF as a PCIe device
#basically does a find and replace so requires out VM xml file to be there
function add_VF_to_VM_xml()
{
  cp template_$1 $1
  sed -i "s/VF_BUS/$__vfbus/g" $1
  sed -i "s/VF_SLOT/$__vfslot/g" $1
  sed -i "s/VF_FUNCTION/$__vffunction/g" $1
}

