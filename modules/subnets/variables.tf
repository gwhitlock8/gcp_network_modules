variable "project_id" {
  description = "The ID of the project where subnets will be created"
  type        = string
}

variable "network_name" {
  description = "The name of the network where subnets will be created"
  type        = string
}

variable "subnets" {
  type = list(object({
    subnet_name                      = string
    subnet_ip                        = string
    subnet_region                    = string
    subnet_description               = optional(string)
    subnet_purpose                   = optional(string)
  }))
  description = "The list of subnets being created"
}
