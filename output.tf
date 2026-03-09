output "instance_name" {
  value = aws_instance.myec2.key_name
}

output "instance_ip"  {
  value = aws_instance.myec2.public_ip
}

output  "instance_type" {
 value = aws_instance.myec2.instance_type
}