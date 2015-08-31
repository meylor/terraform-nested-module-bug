variable "env" { default = "test" }

resource "aws_vpc" "instance" {
  cidr_block = "${lookup(var.prefixes, var.env)}.0.0/16"
}

module "test" {
  source = "./modules/parent"
  vpc_id = "${aws_vpc.instance.id}"
  env = "${var.env}"
}
