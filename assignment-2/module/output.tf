output "vpc_id" {
  value = aws_vpc.vpc_assignment.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "private_subnet_ids_for_db" {
  value = aws_subnet.private_subnets_for_db[*].id
}


output "nat_gateway_id" {
  value = aws_nat_gateway.nat_assignment[*].id
}
