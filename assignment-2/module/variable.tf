variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "private_subnets" {
  description = "Number of private subnets to create"
  type        = number
  default     = 1
}

variable "public_subnets" {
  description = "Number of public subnets to create"
  type        = number
  default     = 1
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "enable_transit_gateway" {
  description = "Enable integration with a Transit Gateway"
  type        = bool
  default     = false
}
