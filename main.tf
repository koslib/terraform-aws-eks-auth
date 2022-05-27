locals {
  roles = [{
    rolearn  = var.nodes_role
    username = "system:node:{{EC2PrivateDNSName}}"
    groups = [
      "system:bootstrappers",
      "system:nodes"
    ]
  }]

  master_roles = [
    for role_arn in var.master_roles :
    {
      rolearn  = role_arn
      username = role_arn
      groups = [
        "system:masters"
      ]
    }

  ]

  users = [
    for user_obj in var.master_users :
    {
      userarn  = user_obj.arn
      username = user_obj.username
      groups = [
        "system:masters"
      ]
    }
  ]
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    // The name of the ConfigMap needs to be `aws-auth`, as specified by AWS. 
    // For more info, please see here: https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
    name      = "aws-auth"
    namespace = "kube-system"
    labels = merge(
      {
        "app.kubernetes.io/managed-by" = "Terraform"
        "terraform.io/module"          = "github.com/koslib/terraform-aws-eks-auth"
      }
    )
  }

  data = {
    mapRoles = yamlencode(concat(local.roles, local.master_roles))
    mapUsers = yamlencode(local.users)
  }

}
