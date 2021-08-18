###############################################################################
### PUBLIC SUBNET                                                           ###
###############################################################################

# PUBLIC SUBNETS FOR EACH AVAILABILITY ZONE
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(values(var.public_subnets), count.index)
  availability_zone       = element(keys(var.public_subnets), count.index)
  map_public_ip_on_launch = true

  tags = merge(
    {
      "Name" = format(
        "%s-${terraform.workspace}-public-%s",
        var.name,
        element(keys(var.public_subnets), count.index),
      ),
      "Network" = "public",
    },
    var.tags,
  )
}

#######################################
# OUTPUTS
#######################################

output "public_subnets" {
  value = [aws_subnet.public.*.id]
}
