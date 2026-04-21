#!/bin/bash

# Fix DNS resolution for public subnet instances
echo "nameserver 8.8.8.8" >> /etc/resolv.conf

# Enable IP forwarding
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

# Install FRR
curl -O https://rpm.frrouting.org/repo/frr-stable-repo.el7.noarch.rpm
rpm -ivh --nodeps ./frr-stable-repo.el7.noarch.rpm
yum install -y frr frr-pythontools

# Fix mgmtd crash issue on AL2
sed -i 's/DAEMONS="zebra mgmtd bgpd/DAEMONS="zebra bgpd/' /usr/lib/frr/frrcommon.sh

# Enable BGP daemon
sed -i 's/bgpd=no/bgpd=yes/' /etc/frr/daemons

# Start FRR
systemctl enable frr
systemctl start frr

# Create GRE tunnel
ip tunnel add gre1 mode gre remote ${peer_eip} ttl 255
ip link set gre1 up
ip addr add ${local_tunnel_ip} dev gre1

# Add loopback route for BGP advertisement
ip route add ${local_vpc_cidr} dev lo

# Add specific route to private subnet
ip route add ${private_subnet} via ${private_gw} dev eth0

# Wait for FRR to fully start
sleep 15

# Configure BGP
vtysh << EOF
configure terminal
router bgp ${local_asn}
 neighbor ${peer_tunnel_ip} remote-as ${peer_asn}
 address-family ipv4 unicast
  network ${local_vpc_cidr}
 exit-address-family
exit
route-map ALLOW-ALL permit 10
exit
router bgp ${local_asn}
 neighbor ${peer_tunnel_ip} route-map ALLOW-ALL in
 neighbor ${peer_tunnel_ip} route-map ALLOW-ALL out
exit
exit
write memory
EOF