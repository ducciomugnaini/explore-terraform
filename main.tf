provider "aws" {

  profile= "default" # <= profile specified on .aws/credential file
  
  # region = "eu-west-1"
  # access_key = "XXXXXXXXXXXXXXXXXXXXXXXXX"
  # secret_key = "XXXXXXXXXXXXXXXXXXXXXXXXX"
}

#variable "vpc_cidr_block" {
#  description = "subnet cidr block"
#  default = "10.0.10.0/24"
#  type = string
#}
#
#variable "subnet_cidr_block" {
#  description = "subnet cidr block"
#}

variable "cidr_blocks"{
  description = "cidr blocks for vpc and subnets"
  type = list(object({
    cidr_block = string
    name = string
  }))
}


variable "environment" {
  description = "deployment environment"
}

variable "avail_zone" {

}

resource "aws_vpc" "developments-vpc" {
  cidr_block = var.cidr_blocks[0].cidr_block
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.developments-vpc.id
  cidr_block = var.cidr_blocks[1].cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name: var.environment
  }
}

#data "aws_vpc" "existing_vpc" {
#  default = true
#}
#
#resource "aws_subnet" "dev-subnet-2" {
#  vpc_id = data.aws_vpc.existing_vpc.id
#  cidr_block = "172.31.48.0/20"
#  tags = {
#    Name: "subnet-2-dev"
#
#  }
#}

output "dev-vpc-id" {
  value = aws_vpc.developments-vpc.id
}

output "dev-subnet-id" {
  value = aws_subnet.dev-subnet-1.id
}