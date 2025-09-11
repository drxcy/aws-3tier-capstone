

provider "aws" {
  region = "ap-south-1"
}

# Get VPC outputs
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}

# Get EC2 outputs (mainly security groups or bastion host if needed)
data "terraform_remote_state" "ec2" {
  backend = "local"
  config = {
    path = "../ec2/terraform.tfstate"
  }
}
