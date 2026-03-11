# 1. Generate the Key Pair (Optional if you want Terraform to handle the .pem)
resource "aws_key_pair" "sentinel_key" {
  key_name   = "sentinel_key"
  public_key = var.public_key
}
# 2. Launch the EC2
resource "aws_instance" "secure_auth_ec2" {
  ami           = "ami-0c101f26f147fa7fd" # Ensure this is Ubuntu for us-east-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.sentinel_key.key_name
  subnet_id     = aws_subnet.public_subnet.id

  # FIXED: Pointing to your custom Security Group, not the default one
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]

  # THE USER DATA SCRIPT (Automating Docker)
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y docker.io
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "secure_auth_ec2"
  }
}
