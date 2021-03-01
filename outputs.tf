output "instance_id" {
  value = aws_instance.docker_instance.id
  description = "ID of EC2 instance"
}

output "public_ip" {
  value = aws_eip.docker_instance.public_ip
  description = "IP of EC2 instance"
}

output "security_group_id" {
  value = aws_security_group.docker_instance.id
  description = "ID of instance security group"
}
