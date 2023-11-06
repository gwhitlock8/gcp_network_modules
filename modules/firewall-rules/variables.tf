variable "project_id" {
  description = "Project id of the project that holds the network."
  type        = string
}

variable "network_name" {
  description = "Name of the network this set of firewall rules applies to."
  type        = string
}

variable "firewall_rules" {
  type = list(object({
    name                 = string
    description          = optional(string, null)
    direction               = optional(string, "INGRESS")
    priority             = optional(number, null)
    ranges                  = optional(list(string),[])
    source_tags             = optional(list(string))
    target_tags             = optional(list(string))

    allow = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })),[])
    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })),[])
  }))
}