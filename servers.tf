

resource "aws_instance" "test-ec2-instance" {
  ami             = var.ami_id
  instance_type   = "t2.micro"
  key_name        = var.ami_key_pair_name
  security_groups = [aws_security_group.ingress-all-test.id]
  tags = {
    Name = var.ami_name
  }
  subnet_id                   = aws_subnet.subnet-uno.id
  associate_public_ip_address = true
  connection {
    host        = aws_instance.test-ec2-instance.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = "secch"
    destination = "/home/ec2-user/secch"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install python37 -y",
      "curl -O https://bootstrap.pypa.io/get-pip.py",
      "python3 get-pip.py --user",
      "export PATH=LOCAL_PATH:$PATH",
      "source ~/.bash_profile",
      "pip install flask --user",
      "nohup python3 /home/ec2-user/secch/main.py > /home/ec2-user/nohup.out &",
      "sleep 1"
    ]
  }



}

