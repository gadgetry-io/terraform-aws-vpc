###############################################################################
### ROUTE TABLE FOR PRIVATE SUBNETS
###############################################################################

# PRIVATE SUBNETS ROUTE TABLE
resource "aws_route_table" "private_subnets" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      "Name" = format(
        "%s-${terraform.workspace}-private-rtb",
        var.name,
      ),
      "Network" = "private",
    },
    var.tags,
  )
}

# PRIVATE SUBNETS ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "private_subnets" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private_subnets.id
}

# DEFAULT ROUTE to NAT GATEWAY for PRIVATE SUBNETS
resource "aws_route" "private_subnet_ngw" {
  count                  = var.enable_nat_gateway ? 1 : 0
  route_table_id         = aws_route_table.private_subnets.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main[0].id
}

#######################################
# OUTPUTS
#######################################

output "private_rtb" {
  value = aws_route_table.private_subnets.id
}
