# Orange (france) consumer FTTH module for RouterOS

## Usage
```terraform
module "orange_ftth" {
  source = "github.com/prototux/terraform-module-routeros-orange-ffth"

  # ONU's ethernet (SFP) interface
  ethernet = {
    physical_name = "sfp-sfpplus1"
    name          = "ether10-1-WAN"
    comment       = "WAN-ONU-2.5GBaseX"
  }

  # Bridge interface
  bridge = {
    name    = "br-wan"
    comment = "WAN bridge"
    mac     = "AA:BB:CC:DD:EE:FF"
  }

  # VLAN interface
  vlan = {
    name    = "vlan832"
    comment = "WAN VLAN"
  }

  # Orange DHCP auth params
  orange_login    = "fti/abcdefg"
  orange_password = "abcdefg"
  orange_chap = {
    id        = "A"
    challenge = "SALTSALTSALTSALT"
  } 
}
```
