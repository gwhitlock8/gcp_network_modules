resource "google_compute_firewall" "firewall_rules" {
  for_each                = length(var.firewall_rules) > 0 ? { for r in var.firewall_rules : r.fw_name => r } : {}
  name                    = each.value.fw_name
  description             = each.value.fw_description
  direction               = each.value.direction
  network                 = var.network_name
  project                 = var.project_id
  source_ranges           = each.value.direction == "INGRESS" ? each.value.ranges : null
  destination_ranges      = each.value.direction == "EGRESS" ? each.value.ranges : null
  source_tags             = each.value.source_tags
  target_tags             = each.value.target_tags
  priority                = each.value.fw_priority

  dynamic "allow" {
    for_each = lookup(each.value, "allow", [])
    content {
      protocol = allow.value.protocol
      ports    = lookup(allow.value, "ports", null)
    }
  }

  dynamic "deny" {
    for_each = lookup(each.value, "deny", [])
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }
}