variable "vpc_id" {}
variable "env" {}

module "service1" {
  source = "../../modules/child"
  vpc_id = "${var.vpc_id}"
  env = "test"
  node = "service1"
}

module "service2" {
  source = "../../modules/child"
  vpc_id = "${var.vpc_id}"
  env = "test"
  node = "service2"
}
