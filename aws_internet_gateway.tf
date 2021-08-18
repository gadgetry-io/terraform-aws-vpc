###############################################################################
### INTERNET GATEWAY (IGW)
###############################################################################

# INTERNET GATEWAY
resource "aws_internet_gateway" "main" {
  vpc_id     = aws_vpc.main.id
  depends_on = [aws_vpc.main]

  tags = merge(
    {
      "Name" = format(
        "%s-${terraform.workspace}-igw",
        var.name,
      )
    },
    var.tags,
  )
}

#######################################
# OUTPUTS
#######################################

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}
