variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  region     = "us-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
}


resource "aws_instance" "jenkins_server" {
  ami           = "ami-0bdb828fd58c52235" # Amazon Linux 2 AMI ID (us-west-1 기준)
  instance_type = "t2.micro" # 원하는 인스턴스 유형

  tags = {
    Name = "jenkins_server" # 인스턴스 이름 태그
  }

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
  EOF
}
