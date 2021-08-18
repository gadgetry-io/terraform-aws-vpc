###############################################################################
### ROUTE TABLE FOR PUBLIC SUBNETS
###############################################################################

# PUBLIC SUBNETS ROUTE TABLE
resource "aws_route_table" "public_subnets" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    {
      "Name" = format(
        "%s-${terraform.workspace}-public-rtb",
        var.name,
      ),
      "Network" = "public",
    },
    var.tags,
  )
}

# PUBLIC SUBNETS ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "public_subnets" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_subnets.id
}

# DEFAULT ROUTE to INTERNET GATEWAY for PUBLIC SUBNETS
resource "aws_route" "public_subnet_igw" {
  route_table_id         = aws_route_table.public_subnets.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

#######################################
# OUTPUTS
#######################################

output "public_rtb" {
  value = aws_route_table.public_subnets.id
}
