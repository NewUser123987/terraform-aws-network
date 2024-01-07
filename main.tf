// define variable for module
variable "cidr_block" {
  default = "10.10.0.0/16"
}
variable "subnet_az" {
  default = []
  type = list(string)
}
variable "subnet_cidr" {
  default = []
  type = list(string)
}

//define resources for module

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
}
resource "aws_subnet" "this" {
  count = length(var.subnet_cidr)
  vpc_id = aws_vpc.this.id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = var.subnet_az[count.index]
}
output "aws_vpc_id" {
  value = aws_vpc.this.id
}
output "subnet_ids" {
  value = aws_subnet.this[*].id
}
