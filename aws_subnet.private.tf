###############################################################################
### PRIVATE SUBNETS
###############################################################################

# CREATE PRIVATE SUBNETS FOR EACH AVAILABILITY ZONE
resource "aws_subnet" "private" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(values(var.private_subnets), count.index)
  availability_zone = element(keys(var.private_subnets), count.index)

  tags = merge(
    {
      "Name" = format(
        "%s-${terraform.workspace}-private-%s",
        var.name,
        element(keys(var.private_subnets), count.index),
      ),
      "Network" = "private",
    },
    var.tags,
  )
}

#######################################
# OUTPUTS
#######################################

output "private_subnets" {
  value = [aws_subnet.private.*.id]
}
