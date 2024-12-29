# Physical Interface
resource "routeros_interface_ethernet" "onu" {
  factory_name    = var.ethernet.physical_name
  name            = var.ethernet.name
  comment         = var.ethernet.comment
  mtu             = 1500
  sfp_rate_select = "high"
}

# Bridge interface
resource "routeros_interface_bridge" "wan" {
  name           = var.bridge.name
  comment        = var.bridge.comment
  admin_mac      = var.bridge.mac
  vlan_filtering = false
}

# VLAN 832 interface
resource "routeros_interface_vlan" "v832" {
  name      = var.vlan.name
  comment   = var.vlan.comment
  interface = routeros_interface_ethernet.onu.name
  vlan_id   = 832
}

# Bridge<>VLAN port
resource "routeros_interface_bridge_port" "bridge_port" {
  bridge    = routeros_interface_bridge.wan.name
  interface = routeros_interface_vlan.v832.name
  pvid      = "1"
}
