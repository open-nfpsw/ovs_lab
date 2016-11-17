if grep -q '/opt/netronome' /etc/apparmor.d/usr.lib.libvirt.virt-aa-helper ; then
echo "already done"
else
sed -i  '/media,mnt,opt,srv/i       /opt/netronome/lib/** rm,' /etc/apparmor.d/usr.lib.libvirt.virt-aa-helper
fi

