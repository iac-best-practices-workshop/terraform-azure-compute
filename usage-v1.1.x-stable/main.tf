module "compute-resources" {
  source = "github.com/iac-best-practices-workshow/terraform-azure-compute?ref=v1.1.x-stable"

  location              = "uksouth"
  resource_group_name   = "iac-workshop-stable"
  hostname              = "computer-stable"
  admin_password        = "Password1234!"
}