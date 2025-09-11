output "vpc_id" {
    value = aws_vpc.main.id
}
output "Public_subnet_id" {
    value = aws_subnet.public.id
}
output "Private_subnet_id_a" {
    value = aws_subnet.private_a.id
} 
output "Private_subnet_id_b" {
    value = aws_subnet.private_b.id
}
