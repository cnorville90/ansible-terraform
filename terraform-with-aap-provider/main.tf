terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }

    aap = {
      source = "ansible/aap"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "tf-demo-aws-ec2-instance-2" {
  ami           = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  tags = {
    Name = "tf-demo-aws-ec2-instance-2"
  }
}

provider "aap" {
  host     = "https://localhost"
  username = "admin"          # CHANGE ME
  password = "ansible123!"    # CHANGE ME
  insecure_skip_verify = true
}

resource "aap_host" "tf-demo-aws-ec2-instance-2" {
  inventory_id = 2
  name = "aws_instance_tf-demo-aws-ec2-instance-2"
  description = "An EC2 instance created by Terraform"
  variables = jsonencode(aws_instance.tf-demo-aws-ec2-instance-2)
}