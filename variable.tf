variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "us-east-1"
}
variable "ami" {
  type = "string"
  default = "ami-096fda3c22c1c990a"
}

variable "instance_type" {
  type    = "string"
  default = "t2.micro"
}

variable "instance_key" {
  type    = "string"
  default = "mwkey"
}

variable "subnetID" {
  type = "string"
  default = "subnet-5f58ae6e"
}
