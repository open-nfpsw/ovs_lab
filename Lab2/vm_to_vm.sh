ovs-ofctl del-flows br0
ovs-ofctl add-flow br0 "icmp,nw_dst=10.0.0.1,action=2"
ovs-ofctl add-flow br0 "icmp,nw_dst=10.0.0.2,action=3"
ovs-ofctl add-flow br0 "arp,action=NORMAL"
