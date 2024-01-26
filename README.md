# terraform-azure-compute

A Terraform module repository for Azure compute resources. Used in the IaC Best Practices Workshop to demonstrate version pinning and module release strategies.

## Table of Contents

- [terraform-azure-compute](#terraform-azure-compute)
  - [Table of Contents](#table-of-contents)
  - [Version Pinning (module consumer side)](#version-pinning-module-consumer-side)
    - [Cloning the project](#cloning-the-project)
    - [Provisioning the example resources](#provisioning-the-example-resources)
  - [Version Pinning (module builder side)](#version-pinning-module-builder-side)
    - [Clone the Repository](#clone-the-repository)
    - [Modify the Module](#modify-the-module)
  - [Testing Existing Configuration (module builder side)](#testing-existing-configuration-module-builder-side)

## Version Pinning (module consumer side)

### Cloning the project

Clone the `terraform-version-pinning` project. This project references `terraform-azure-compute` module:

```sh
$ git clone git@github.com:iac-best-practices-workshow/terraform-version-pinning.git
$ cd terraform-version-pinning
```

### Provisioning the example resources

Open `main.tf` and change the module input values:

```hcl
module "azure_compute" {
    source = "github.com/iac-best-practices-workshop/terraform-azure-compute"

    resource_group_name = "workshop-resource-group"
    location = "" # "Azure region in which to deploy resources"
    vnet_name = "" # "Name of the virtual network"
    subnet_name = "" # "Name of the subnet"
    ssh_public_key = "" # "SSH public key for VM access"
}
```

Next, run `terraform init | plan | apply` to provision the resources.

## Version Pinning (module builder side)

Now, you will practice adding a new resource to the `terraform-azure-compute` module and releasing a new version. You will then see how version pinning techniques ensure that existing Terraform configurations are not impacted by the module updates.

### Clone the Repository

Clone the `terraform-azure-compute` repository to your local machine if you haven't already:

```sh
git clone git@github.com:iac-best-practices-workshow/terraform-azure-compute.git
cd terraform-azure-compute
```

### Modify the Module

1. Open the `main.tf` file in the `terraform-azure-compute` module repository.
2. Add a new resource to the module, such as an additional Azure Virtual Machine, Virtual Network, or any other Azure resource of your choice.
    Example:

    ```hcl
    resource "azurerm_virtual_machine" "additional_vm" {
        name                  = "additional-vm"
        location              = var.location
        resource_group_name   = var.resource_group_name
        # Add more configuration options here
    }
    ```

3. Commit your changes to the repository and create a new Git tag for the new version:

```sh
git add .
git commit -m "Add additional resource and update module version"
git tag v1.1.0  # Use the appropriate version number
```

4. You can "Release" the new version by pushing/merging your changes to your remote branch.

```sh
git push origin v1.1.0
```

## Testing Existing Configuration (module builder side)

1. In other Terraform configurations that use the `terraform-azure-compute` module update the module to use the previous version `v1.0.0`.

```hcl
module "azure_compute" {
    source        = "github.com/iac-best-practices-workshop/terraform-azure-compute?ref=1.0.0"
    # Other module configuration here
}
```

2. Apply the Terraform configuration.

```sh
terraform init
terraform apply
```

**Observe No Impact:**

- Observe that your existing configurations are not impacted by the module updates due to version pinning. The new resource should be created, and existing resources should remain unchanged.

3. Now, update again you module code to point to the version `v1.1.0`:

```hcl
module "azure_compute" {
    source        = "github.com/iac-best-practices-workshop/terraform-azure-compute?ref=1.0.0"
    # Other module configuration here
}
```

4. Plan the Terraform configuration.

```sh
terraform plan
```

**Observe the impact:**

- Observe that your existing configurations now are impacted by the module updates due to the version pinning.

By completing this task, you have practiced version pinning and module release strategies, ensuring the stability of existing Terraform configurations even as the module evolves.
