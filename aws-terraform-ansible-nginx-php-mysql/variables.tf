variable "aws_profile" {
  description = "Amazone Profile ~/.aws"
  type        = string
  default     = "aws-ashwin"
}
variable "aws_image_id" {
  description = "Amazone Machine Image"
  type        = string
  default     = "ami-05f7491af5eef733a"
}
variable "aws_region_id" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}
variable "aws_vpc_id" {
  description = "AWS region"
  type        = string
  default     = "vpc-fc13ae96"
}
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
  default     = "subnet-7f268033"
}
variable "aws_vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "aws_ssh_user" {
  description = "AWS region"
  type        = string
  default     = "ubuntu"
}
variable "aws_key_name" {
  description = "AWS region"
  type        = string
  default     = "devops"
}
variable "aws_private_key_path" {
  description = "AWS region"
  type        = string
  default     = "keys/devops.pem"
}