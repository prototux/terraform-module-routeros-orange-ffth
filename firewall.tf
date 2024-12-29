# Set DHCP packets' priority to 6 (required by Orange)
resource "routeros_interface_bridge_filter" "dhcp_prio" {
  comment = "Set DHCP priority for Orange"
  chain   = "output"

  # Trigger: out on the 832 VLAN, UDP/IP port 67
  out_interface = routeros_interface_vlan.v832.name
  mac_protocol  = "ip"
  dst_port      = "67"
  ip_protocol   = "udp"

  # Log the action
  log        = true
  log_prefix = "Set DHCP priority"

  # Set the priority
  action       = "set-priority"
  new_priority = 6
  #passthrough = yes // missing param on the provider, bug reported
}

# Well, it's obvious, but... it's the classic NAT rule
resource "routeros_ip_firewall_nat" "snat" {
  comment       = "Orange SNAT"
  chain         = "srcnat"

  # Out on the bridge, to any address
  out_interface = routeros_interface_bridge.wan.name
  to_addresses  = "0.0.0.0"

  # Masquerade
  action        = "masquerade"
}
