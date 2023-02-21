variable "region" {
  type          = string
  default       = "eu-west-1"
}
variable "env" {
    type        = string
    default     = "tf-dev"
    description = "Environment Name"
}

variable "cluster_map" {
  type        = map
  default     = {
    name                   = "eks-test-manoj"
    vers                   = "1.24"
    enable_log_types       = "api,audit,authenticator,controllerManager,scheduler"
    subnet_ids             = "subnet-0e6e5aec0f973e27a,subnet-0f5428af7cde7025e"
    security_group_ids     = "sg-aca8fcca"
    ### Both given below variables cannot have same value like true or false
    managed_node_groups    = "true"
    managed_farget_profile = "false"
    ##############################
  }
  description = "EKS Cluster Hash Map"
}

###Only used if managed_node_groups is true###
variable "nodegroup_map" {
  type        = list
  default     = [
    {
      max_size        = "2"
      min_size        = "1"
      desired_size    = "1"
      disk_size       = "50"
      ami_type        = "AL2_x86_64"
      capacity_type   = "ON_DEMAND"
      instance_types  = "t3.medium"
      max_unavailable = 1
      subnet_ids      = "subnet-0e6e5aec0f973e27a,subnet-0f5428af7cde7025e"
    }
  ]
  description = "EKS Cluster Node Group Hash Map"
}