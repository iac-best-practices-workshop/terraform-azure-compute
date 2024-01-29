# Terraform Azure Compute Module

This Terraform module is crafted for Azure compute resources, showcasing best practices in version pinning and module release strategies during the IaC Best Practices Workshop.

## Table of Contents

- [Introduction](#terraform-azure-compute-module)
- [Table of Contents](#table-of-contents)
- [Version Pinning for Consumers](#version-pinning-for-consumers)
- [Version Pinning for Developers](#version-pinning-for-developers)
- [Testing Configuration Stability](#testing-configuration-stability)

## Version Pinning for Consumers

### Project Cloning

Fork this project first.

![Forking Illustration](./images/image.png)

Then, clone it to your space and navigate to the directory:

```sh
git clone git@github.com:{your-username}/terraform-version-pinning.git
cd terraform-version-pinning
```

### Resource Provisioning with v1.0.0

Navigate to `usage-v1.0.0`:

```sh
cd usage-v1.0.0
```

`main.tf` here uses version `v1.0.0`:

```hcl
module "compute-resources" {
  source = "github.com/iac-best-practices-workshow/terraform-azure-compute?ref=v1.0.0"
  # Additional configuration...
}
```

Run `terraform init | plan | apply` to set up the resources.

### Resource Provisioning with v1.1.0

Switch to `usage-v1.1.0`:

```sh
cd ../usage-v1.1.0
```

This `main.tf` points to `v1.1.0`:

```hcl
module "compute-resources" {
  source = "github.com/iac-best-practices-workshow/terraform-azure-compute?ref=v1.1.0"
  # Additional configuration...
}
```

Execute `terraform init | plan | apply`. Notice the VM now has two network interfaces.

## Version Pinning for Developers

This section guides you through adding a resource to `terraform-azure-compute` and releasing a new version, demonstrating the robustness of version pinning.

### Repository Cloning

If not already done, clone the repository:

```sh
git clone git@github.com:{your-username}/terraform-version-pinning.git
cd terraform-version-pinning
```

### Module Modification

1. Edit `main.tf` in the `terraform-azure-compute` repository.
2. Introduce a new Azure resource:

```hcl
resource "azurerm_virtual_machine" "additional_vm" {
    # Configuration details...
}
```

3. Commit and tag the new version:

```sh
git add .
git commit -m "Add new resource, update module version"
git tag v1.2.0
git push origin v1.2.0
```

## Testing Configuration Stability

Verify that the `v1.0.0` configurations remain unaffected by the new release:

1. Return to `usage-v1.0.0` and run terraform plan.
2. Observe no changes due to version pinning.
3. Update `usage-v1.0.0` to point to your project ref`v1.2.0` and observe the impacts:

```hcl
module "compute-resources" {
  source = "github.com/{your-username}/terraform-azure-compute?ref=v1.2.0"
  # Additional configuration...
}
```

---

**Congratulations!** You've mastered using version pinning to maintain stability in Terraform configurations as your module evolves, ensuring seamless experiences for your users.
