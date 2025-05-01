variable "region" {
  default = "us-east-1"
}

variable "ami" {
  default = "ami-084568db4383264d4"
}

variable "instance" {
  default = "t2.medium"
}

variable "key_name" {
  description = "Name of the EC2 key pair (do not include .pub)"
  default     = "my-key"
}
