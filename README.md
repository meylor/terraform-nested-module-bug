# terraform-nested-module-bug

## Overview

There is a bug involving nested modules in Terraform ( https://www.terraform.io/docs/modules/create.html ). I've detailed the error that I'm seeing and the steps to reproduce the error below. The corresponding issue is located at https://github.com/hashicorp/terraform/issues/3114

## Steps to reproduce
* Using Terraform v0.6.3

1. Clone https://github.com/meylor/terraform-nested-module-bug.git
2. Edit terraform-nested-module-bug/terraform.tfvars to add AWS keys.
3. Make sure that map.tf isn't using overlapping address space as your current infrastructure
4. Set your AWS_REGION in an environment variable ```export AWS_REGION=us-west-1```
5. Run ```terraform get``` to get the modules
6. Run ```terraform plan``` to see the resources that will be generated
7. Run ```terraform apply``` to generate the resources.
** This will call a .tf state that will call a parent module, then a child module
8. The resources will be provisioned correctly
9. in terraform-nested-module-bug/test.tf comment out the following section:
```
#module "test" {
#  source = "./modules/parent"
#  vpc_id = "${aws_vpc.instance.id}"
#  env = "${var.env}"
#}
```
10. Run ```terraform plan``` to see the same error that I'm seeing below.
```
meylor@meylor:~/terraform-nested-module-bug$ terraform plan
There are warnings and/or errors related to your configuration. Please
fix these before continuing.

Errors:

  * 14 error(s) occurred:

* Provider 'aws' already initialized
* Provisioner 'remote-exec' already initialized
* Provider 'aws' already initialized
* Provisioner 'remote-exec' already initialized
* Provisioner 'remote-exec' already initialized
* Provisioner 'file' already initialized
* Provisioner 'file' already initialized
* Provisioner 'local-exec' already initialized
* Provisioner 'local-exec' already initialized
* Provisioner 'chef' already initialized
* Provisioner 'chef' already initialized
* Provisioner 'chef' already initialized
* Provisioner 'file' already initialized
* Provisioner 'local-exec' already initialized
```

