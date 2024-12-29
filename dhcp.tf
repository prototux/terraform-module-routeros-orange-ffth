# DHCP Client
resource "routeros_ip_dhcp_client" "orange_dhcp" {
  interface              = routeros_interface_bridge.wan.name
  comment                = "Orange DHCP"
  add_default_route      = "yes"
  default_route_distance = 1
  use_peer_dns           = false
  use_peer_ntp           = false
  dhcp_options           = "hostname,clientid,authsend,userclass,vendor-class-identifier"
}

# Module that create the DHCP options strings
module "orange_dhcp" {
  source = "github.com/prototux/terraform-module-orange-dhcp"

  login    = var.orange_login
  password = var.orange_password
  chap = {
    id        = var.orange_chap.id
    challenge = var.orange_chap.challenge
  }
}

# DHCP Options (from the module)
resource "routeros_ip_dhcp_client_option" "authsend" {
  name  = "authsend"
  code  = 90
  value = join("", ["0x", module.orange_dhcp.dhcp_option_auth])
}

resource "routeros_ip_dhcp_client_option" "user-class" {
  name  = "userclass"
  code  = 77
  value = join("", ["0x", module.orange_dhcp.dhcp_option_userclass])
}

resource "routeros_ip_dhcp_client_option" "vendor-class" {
  name  = "vendor-class-identifier"
  code  = 60
  value = join("", ["0x", module.orange_dhcp.dhcp_option_vendor])
}
