terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.49.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}


resource "aws_security_group" "allow_trafic" {
  name        = "my-security-group"
  description = "Allow inbound traffic"
  

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}


resource "aws_instance" "build_server" {
  ami           = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  key_name = "key1"
  user_data = "${file("docker-install.sh")}"
  vpc_security_group_ids = [aws_security_group.allow_trafic.id]
  tags = {
    Name = "build"
    }
  }

resource "aws_instance" "stage_server" {
  ami           = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  key_name = "key1"
  user_data = "${file("docker-install.sh")}"
  vpc_security_group_ids = [aws_security_group.allow_trafic.id]
  tags = {
    Name = "stage"
    }
  }
