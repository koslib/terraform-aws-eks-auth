variable "cluster_name" {
  type        = string
  description = "The cluster to apply the auth config on."
}

variable "aws_region" {
  type        = string
  description = "Your cluster's AWS region."
}

variable "aws_profile" {
  type        = string
  default     = "default"
  description = "In case you use multiple AWS profiles, specify which one to use here. Defaults to `default`."
}

variable "nodes_role" {
  type        = string
  description = "The role that was created while provisioning the cluster and should be used by EC2 instances to interact with the cluster."
}

variable "master_users" {
  type = list(object({
    username = string
    arn      = string
  }))
  description = "List of user objects that will have master permissions on the cluster. Object consists of username and ARN (strings)."
}

variable "master_roles" {
  type        = list(string)
  default     = []
  description = "List of IAM role ARNs that will have master permissions on the cluster."
}
