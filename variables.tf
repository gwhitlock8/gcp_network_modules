variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
}

variable "region" {}

variable "zone" {}

variable "network_name" {
  description = "The name of the network being created"
  type        = string
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')"
}

variable "subnets" {
  type = list(object({
    subnet_name                      = string
    subnet_ip                        = string
    subnet_region                    = string
    subnet_description               = optional(string)
    subnet_purpose                          = optional(string)
  }))
  description = "The list of subnets being created"
}

variable "firewall_rules" {
  type = list(object({
    fw_name                    = string
    fw_description             = optional(string, null)
    direction               = optional(string, "INGRESS")
    fw_priority                = optional(number, null)
    ranges                  = optional(list(string), [])
    source_tags             = optional(list(string))
    target_tags             = optional(list(string))

    allow = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
  }))
}



variable "description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  default     = ""
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}

variable "mtu" {
  type        = number
  description = "The network MTU (If set to 0, meaning MTU is unset - defaults to '1460'). Recommended values: 1460 (default for historic reasons), 1500 (Internet default), or 8896 (for Jumbo packets). Allowed are all values in the range 1300 to 8896, inclusively."
  default     = 0
}
