resource "aws_vpc" "test-env" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "test-env"
  }
}


output "URL" {
  value = "http://${aws_instance.test-ec2-instance.public_ip}:8080"
}