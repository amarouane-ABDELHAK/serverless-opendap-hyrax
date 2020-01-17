output "vpc_id" {
  value = aws_vpc.main.id
}

output "service_subnet_private_ids" {
  value = aws_subnet.private.*.id
}

output "service_subnet_public_ids" {
  value = aws_subnet.public.*.id
}