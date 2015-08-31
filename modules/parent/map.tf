# prefix
variable "prefixes" {
  default = {
    test = "10.50"
  }
}

# subnets
variable "subnets" {
  default = {
    service1 = "1.0/24"
    service2 = "2.0/24"
  }
}
