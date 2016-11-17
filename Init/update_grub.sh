if grep -q iommu=pt /etc/default/grub ; then
echo "already done"
else
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="intel_iommu=on iommu=pt /' /etc/default/grub
update-grub2
fi

