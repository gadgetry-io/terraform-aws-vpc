###############################################################################
### VIRTUAL PRIVATE CLOUD                                                   ###
###############################################################################

# VIRTUAL PRIVATE CLOUD
resource "aws_vpc" "main" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  instance_tenancy     = var.instance_tenancy

  tags = merge(
    {
      "Name" = format(
        "%s-${terraform.workspace}",
        var.name,
      )
    },
    var.tags,
  )
}

#######################################
# OUTPUTS
#######################################

output "vpc_id" {
  value = aws_vpc.main.id
}

output "cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "network_acl_id" {
  value = aws_vpc.main.default_network_acl_id
}
