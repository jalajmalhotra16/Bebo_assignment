output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "private_subnet_for_db_ids" {
  value = module.vpc.private_subnet_ids_for_db
}


output "nat_gateway_id" {
  value = module.vpc.nat_gateway_id
}
