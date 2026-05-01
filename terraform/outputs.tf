output "instance_id" {
  description = "ID of the demo EC2 instance."
  value       = aws_instance.web.id
}

output "security_group_id" {
  description = "ID of the web security group."
  value       = aws_security_group.web.id
}
