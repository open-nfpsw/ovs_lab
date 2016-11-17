ovs-vsctl add-br br0
ovs-vsctl add-port br0 sdn_p0 -- set interface sdn_p0 ofport_request=1
ovs-vsctl add-port br0 sdn_v0.2 -- set interface sdn_v0.2 ofport_request=2
ovs-vsctl add-port br0 sdn_v0.3 -- set interface sdn_v0.3 ofport_request=3
