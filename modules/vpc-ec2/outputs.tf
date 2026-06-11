output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "web_sg_id" {
  value = aws_security_group.web_sg.id
}
