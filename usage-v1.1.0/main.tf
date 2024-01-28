module "compute-resources" {
  source = "github.com/iac-best-practices-workshow/terraform-azure-compute?ref=v1.1.0"

  location              = "uksouth"
  resource_group_name   = "iac-workshop-v110"
  hostname              = "computer-v110"
  admin_password        = "Password1234!"
}