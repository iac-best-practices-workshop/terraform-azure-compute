module "compute-resources" {
  source = "github.com/iac-best-practices-workshow/terraform-azure-compute?ref=v1.0.0"

  location              = "uksouth"
  resource_group_name   = "iac-workshop-v100"
  hostname              = "computer-v100"
  admin_password        = "Password1234!"
}
