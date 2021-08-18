###############################################################################
### NAT GATEWAY (NGW)
###############################################################################

# ELASTIC IP FOR NAT GATEWAY
resource "aws_eip" "ngw" {
  count = var.enable_nat_gateway ? 1 : 0
  vpc        = true
  depends_on = [aws_vpc.main]
}

# NAT GATEWAY WITH ELASTIC IP
resource "aws_nat_gateway" "main" {
  count = var.enable_nat_gateway ? 1 : 0
  allocation_id = aws_eip.ngw[0].id
  subnet_id     = aws_subnet.public[0].id
  depends_on = [aws_internet_gateway.main]

  tags = merge(
    {
      "Name" = format(
        "%s-${terraform.workspace}-ngw",
        var.name,
      )
    },
    var.tags,
  )
}

#######################################
# OUTPUTS
#######################################

output "nat_gateway_ip" {
  description = "The Public IPv4 Address of the NAT Gateway"
  value       = aws_eip.ngw[0].public_ip
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.main[0].id
}
