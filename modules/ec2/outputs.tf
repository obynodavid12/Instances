output "public_ip" {
  value = aws_instance.ubuntu_public.public_ip
}

output "private_ip" {
  value = aws_instance.ubuntu_private.private_ip
}
