################################################################################
### MODULE
################################################################################

variable "name" {
  description = "Name to be used on all the resources provisioned by this module as identifier"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources deployed by this module"
  type        = map(string)
  default     = {}
}

################################################################################
### VPC
################################################################################

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR but should be overridden"
  type        = string
  default     = "10.100.0.0/16"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

################################################################################
### SUBNETS
################################################################################

variable "private_subnets" {
  description = "A map of availability zones and cidr blocks to use for private subnets"
  type        = map(string)
}

variable "public_subnets" {
  description = "A map of availability zones and cidr blocks to use for public subnets"
  type        = map(string)
}

################################################################################
### GATEWAYS
################################################################################

variable "enable_nat_gateway" {
  description = "Should be true to create NAT Gateway with EIP Public IP for the VPC"
  type        = bool
  default     = true
}

################################################################################
### NETWORK ACCESS CONTROL LIST (ACL)
################################################################################

variable "manage_default_network_acl" {
  description = "Should be true to configure Default Network ACL for the VPC"
  type        = bool
  default     = true
}

variable "default_network_acl_ingress" {
  description = "List of maps of engress rules to set on the default network acl"
  type        = list(map(string))
  default     = null
}

variable "default_network_acl_egress" {
  description = "List of maps of engress rules to set on the default network acl"
  type        = list(map(string))
  default     = null
}

################################################################################
### SECURITY GROUP (DEFAULT)
################################################################################

variable "manage_default_security_group" {
  description = "Should be true to configure Default Security Group for the VPC"
  type        = bool
  default     = true
}

variable "default_security_group_ingress" {
  description = "List of maps of ingress rules to set on the default security group"
  type        = list(map(string))
  default     = null
}

variable "default_security_group_egress" {
  description = "List of maps of egress rules to set on the default security group"
  type        = list(map(string))
  default     = null
}


################################################################################
### ENDPOINTS
################################################################################

variable "enable_vpc_endpoint_s3" {
  description = "Should be true to create S3 VPC Endpoint in the VPC"
  type        = bool
  default     = true
}
