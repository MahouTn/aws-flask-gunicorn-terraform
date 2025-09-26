variable "cidr" {
  type = string
  default = "10.0.0.0/24"
}

variable "public_subnet_cidr" {
  type = string
  default = "10.0.0.0/25"
}

variable "internet" {
  type = string
  default = "0.0.0.0/0"
}

variable "ami" {
  type = string
  description = "The AMI ID for the EC2 instance."
  default = "ami-0bc691261a82b32bc"
}