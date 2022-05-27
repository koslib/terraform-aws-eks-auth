# terraform-aws-eks-auth
A Terraform module facilitating IAM users and roles authentication for EKS clusters

## Usage

> Provisioning the EKS cluster is out of scope for this module. Retrieving the node role needed to "connect" the control plane with the worker node groups should be done in connection to the method you used to bootstrap your EKS cluster.

```
module "kube_auth" {
    source = "koslib/terraform-aws-eks-auth"

    aws_region   = "eu-north-1"
    aws_profile  = "production"
    cluster_name = "my-cool-apps"
    master_users = [
        {
        username = "my-username"
        arn      = "arn:aws:iam::012345678912:user/my-username"
        },
        ....

    ]
    nodes_role = "arn:aws:iam::012345678912:role/my-nodes-role-name-here"
}

```

Editing this when new IAM users/roles need to extend the list will also update the `ConfigMap` once this is planned and applied.


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.72 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.10 |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_name | Indicates the cluster name to apply the config on. | `string` | NA | yes |
| aws_region | Indicates the AWS region your EKS cluster is in. | `string` | NA | yes |
| aws_profile | In case multiple profiles are used, specify the AWS profile to be used when applying this module | `string` | `default` | no |
| nodes_role | The IAM role created while provisioning the EKS cluster and allows worker node groups to communicate with the control plane | `string` | NA | yes |
| master_users | A list of users to get `master` permissions on the cluster | `list({username=string arn=string})`. Can be empty.| NA | yes |
| master_roles | A list of IAM roles to give `master` permissions on the cluster. | `list(string)` | `[]` | no |



## Contributing

This module is not feature-complete, eg. it does not support still not-master accounts or other roles. Feel free to submit feedback and ideas in the [issues](https://github.com/koslib/terraform-aws-eks-auth/issues) or submit a [Pull Request](https://github.com/koslib/terraform-aws-eks-auth/pulls)!

## Credits

This module was inspired by common work and originally collaborated on it with [Paris](https://twitter.com/pariskasid).
