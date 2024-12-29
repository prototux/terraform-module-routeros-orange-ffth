# ONU's SFP interface
variable "ethernet" {
  type = object({
    physical_name = string
    name          = string
    comment       = string
  })
  description = "Physical interface parameters"

  default = {
    physical_name = "sfp-sfpplus1"
    name          = "ether10-1-WAN"
    comment       = "WAN-ONU-2.5GBaseX"
  }
}

# Bridge interface
variable "bridge" {
  type = object({
    name    = string
    comment = string
    mac     = string
  })
  description = "Bridge interface parameters"

  default = {
    name    = "br-wan"
    comment = "WAN bridge"
    mac     = "AA:BB:CC:DD:EE:FF"
  }
}

# VLAN interface
variable "vlan" {
  type = object({
    name    = string
    comment = string
  })
  description = "VLAN interface paramters"

  default = {
    name    = "vlan832"
    comment = "WAN VLAN"
  }
}

# Orange PPP login
variable "orange_login" {
  type = string
}

# Orange PPP password
variable "orange_password" {
  type = string
}

# Orange auth CHAP params
variable "orange_chap" {
  type = object({
    id        = string
    challenge = string
  })

  default = {
    id        = "A"
    challenge = "SALTSALTSALTSALT"
  }
}
