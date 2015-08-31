variable "vpc_id" {}
variable "env" {}
variable "node" {}

resource "aws_subnet" "subnet" {
    vpc_id = "${var.vpc_id}"
    cidr_block = "${lookup(var.prefixes, var.env)}.${lookup(var.subnets, var.node)}"
    tags {
        Name = "${var.node}-${var.env}"
    }
}
