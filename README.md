# terraform-nested-module-bug

## Overview

I believe this is a bug involving nested modules in Terraform ( https://www.terraform.io/docs/modules/create.html ). I've detailed the error that I'm seeing and the steps to reproduce the error below.


## Steps to reproduce
1. Clone https://github.com/meylor/terraform-nested-module-bug.git
2. Edit terraform-nested-module-bug/terraform.tfvars to add AWS keys and the name of your SSH key
3. Make sure that map.tf isn't using overlapping address space as your current infrastructure
4. Run ```terraform plan``` to see the resources that will be generated
5. Run ```terraform apply``` to generate the resources.
** This will call a .tf state that will call a parent module, then a child module
6. The resources will be provisioned correctly
7. in terraform-nested-module-bug/test.tf comment out the following section:
```
#module "test" {
#  source = "./modules/parent"
#  vpc_id = "${aws_vpc.instance.id}"
#  env = "${var.env}"
#}
```
8. Run ```terraform plan``` to see the same error that I'm seeing below.
```
meylor@meylor:~/infra/test$ terraform plan
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

