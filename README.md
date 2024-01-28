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

### Provisioning the resources using version v1.0.0

Change directory to `usage-v1.0.0`:

```sh
cd usage-v1.0.0
```

Notice that `main.tf` references the version `v1.0.0`:

```hcl
module "compute-resources" {
  source = "github.com/iac-best-practices-workshow/terraform-azure-compute?ref=v1.0.0"

  location              = "uksouth"
  resource_group_name   = "iac-workshop-v100"
  hostname              = "computer-100"
  admin_password        = "Password1234!"
}
```

Next, run `terraform init | plan | apply` to provision the resources.

### Provisioning the resources using version v1.1.0

Change directory to `usage-v1.1.0`:

```sh
cd ../usage-v1.1.0
```

Notice that `main.tf` references the version `v1.1.0`:

```hcl
module "compute-resources" {
  source = "github.com/iac-best-practices-workshow/terraform-azure-compute?ref=v1.1.0"

  location              = "uksouth"
  resource_group_name   = "iac-workshop-v110"
  hostname              = "computer-110"
  admin_password        = "Password1234!"
}
```

Run `terraform init | plan | apply` to provision the resources. Notice that the VM created using version v1.1.0 uses two network interfaces instead of one.

### Create a new version

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
git tag v1.2.0  # Use the appropriate version number
```

4. You can "Release" the new version by pushing/merging your changes to your remote branch.

```sh
git push origin v1.2.0
```

## Testing Existing Configuration

To confirm that users of version v.1.0.0 were not affected by your new version, switch back to directories usage-v1.0.0 and run `terraform plan`.

**Observe No Impact:**

- Observe that your existing configurations are not impacted by the module updates due to version pinning.

Now, update again the code inside `usage-v1.0.0` to point to the version `v1.2.0`. Notice that it should add the additional network interface added in v.1.1.0 and the VM added in v.1.2.0:

By completing this task, you have practiced version pinning and module release strategies, ensuring the stability of existing Terraform configurations as the module evolves.
