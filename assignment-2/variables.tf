variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnets" {
  description = "Number of private subnets"
  type        = number
}

variable "public_subnets" {
  description = "Number of public subnets"
  type        = number
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}
