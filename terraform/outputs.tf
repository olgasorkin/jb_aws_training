output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.builder.id
}

output "public_ip" {
  description = "Public IP address"
  value       = aws_instance.builder.public_ip
}

output "public_dns" {
  description = "Public DNS"
  value       = aws_instance.builder.public_dns
}

output "ssh_private_key_path" {
  description = "Local path to the private key (contents are NOT exposed)"
  value       = local.private_key_path
}

output "ssh_command" {
  description = "Convenient SSH command"
  value       = "ssh -i ${local.private_key_path} ubuntu@${aws_instance.builder.public_ip}"
}
output "security_group_id" {
  description = "ID of the security group used by the instance"
  value       = aws_security_group.builder_ssh.id
}