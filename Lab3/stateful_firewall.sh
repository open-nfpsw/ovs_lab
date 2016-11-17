ovs-ofctl del-flows br0
ovs-ofctl add-flow br0 "priority=60,ct_state=-trk,icmp,action=ct(commit,table=0)"
ovs-ofctl add-flow br0 "priority=50,ct_state=+trk+new,icmp,nw_dst=10.0.0.2,action=3"
ovs-ofctl add-flow br0 "priority=50,ct_state=+trk+new,icmp,nw_dst=10.0.0.1,action=drop"
ovs-ofctl add-flow br0 "priority=50,ct_state=+trk+est,icmp,nw_dst=10.0.0.1,action=2"
ovs-ofctl add-flow br0 "priority=50,ct_state=+trk+est,icmp,nw_dst=10.0.0.2,action=3"
ovs-ofctl add-flow br0 "priority=20,arp,action=NORMAL"
