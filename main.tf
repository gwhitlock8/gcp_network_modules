provider "google" {
    credentials = file("./credentials.json")
    project = "${var.project_id}"
    region = "${var.region}"
    zone = "${var.zone}"
}

/******************************************
	VPC configuration
 *****************************************/
module "vpc" {
  source                                    = "./modules/vpc"
  network_name                              = var.network_name
  auto_create_subnetworks                   = var.auto_create_subnetworks
  routing_mode                              = var.routing_mode
  project_id                                = var.project_id
  description                               = var.description
  mtu                                       = var.mtu
}

/******************************************
	Subnet configuration
 *****************************************/
module "subnets" {
  source           = "./modules/subnets"
  project_id       = var.project_id
  network_name     = module.vpc.network_name
  subnets          = var.subnets
}

/******************************************
	Firewall rules
 *****************************************/
locals {
  rules = [
    for f in var.firewall_rules : {
      fw_name                    = lookup(f,"fw_name")
      direction               = lookup(f,"direction", "INGRESS")
      fw_priority                = lookup(f, "fw_priority", null)
      fw_description             = lookup(f, "fw_description", null)
      ranges                  = lookup(f, "ranges", null)
      source_tags             = lookup(f, "source_tags", null)
      target_tags             = lookup(f, "target_tags", null)
      allow                   = lookup(f, "allow", [])
      deny                    = lookup(f, "deny", [])
    }
  ]
}

module "firewall_rules" {
  source        = "./modules/firewall-rules"
  project_id    = var.project_id
  network_name  = module.vpc.network_name
  firewall_rules = local.rules
}