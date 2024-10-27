
provider "aws" {
  region     = "us-west-1"
}


resource "aws_instance" "jenkins_server" {
  ami           = "ami-0da424eb883458071" # Amazon Linux 2 AMI ID (us-west-1 기준)
  instance_type = "t2.micro" # 원하는 인스턴스 유형
  key_name = "jenkins_practice"
  tags = {
    Name = "jenkins_server" # 인스턴스 이름 태그
  }

   vpc_security_group_ids = [aws_security_group.my_app_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
  EOF
}

resource "aws_security_group" "my_app_sg" {
  name        = "my_app_sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere, restrict as needed
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere, restrict as needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}