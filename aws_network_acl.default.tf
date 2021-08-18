###############################################################################
### NETWORK ACCESS CONTROL LIST (ACL)
###############################################################################

resource "aws_default_network_acl" "main" {
  count = var.manage_default_network_acl ? 1 : 0

  default_network_acl_id = aws_vpc.main.default_network_acl_id

  dynamic "ingress" {
    for_each = var.default_network_acl_ingress
    content {
      rule_no         = ingress.value.rule_number
      action          = ingress.value.action
      cidr_block      = lookup(ingress.value, "cidr_block", null)
      from_port       = lookup(ingress.value, "from_port", 0)
      to_port         = lookup(ingress.value, "to_port", 0)
      protocol        = lookup(ingress.value, "protocol", "-1")
      icmp_code       = lookup(ingress.value, "icmp_code", null)
      icmp_type       = lookup(ingress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(ingress.value, "ipv6_cidr_block", null)
    }
  }

  dynamic "egress" {
    for_each = var.default_network_acl_egress
    content {
      rule_no         = egress.value.rule_number
      action          = egress.value.action
      cidr_block      = lookup(egress.value, "cidr_block", null)
      from_port       = lookup(egress.value, "from_port", 0)
      to_port         = lookup(egress.value, "to_port", 0)
      protocol        = lookup(egress.value, "protocol", "-1")
      icmp_code       = lookup(egress.value, "icmp_code", null)
      icmp_type       = lookup(egress.value, "icmp_type", null)
      ipv6_cidr_block = lookup(egress.value, "ipv6_cidr_block", null)
    }
  }

  tags = merge(
    {
      "Name" = format(
        "%s-${terraform.workspace}-default-acl",
        var.name,
      )
    },
    var.tags,
  )

  lifecycle {
    ignore_changes = [
      subnet_ids,
    ]
  }
}

#######################################
# OUTPUTS
#######################################

output "default_network_acl_id" {
  value = aws_default_network_acl.main[0].id
}
