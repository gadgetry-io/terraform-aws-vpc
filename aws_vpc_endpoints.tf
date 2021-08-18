###############################################################################
### VPC ENDPOINTS                                                           ###
###############################################################################

data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
  service_type = "Gateway"
}

# VPC ENDPOINT FOR S3
resource "aws_vpc_endpoint" "s3" {
  count = var.enable_vpc_endpoint_s3 ? 1 : 0
  vpc_id            = aws_vpc.main.id
  service_name      = data.aws_vpc_endpoint_service.s3.service_name
  auto_accept       = true
  vpc_endpoint_type = "Gateway"

  tags = merge(
    {
      "Name" = format(
        "%s-${terraform.workspace}-s3-endpoint",
        var.name,
      )
    },
    var.tags,
  )

  route_table_ids = [
    aws_route_table.private_subnets.id,
    aws_route_table.public_subnets.id,
  ]
}
