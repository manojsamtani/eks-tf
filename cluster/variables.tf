variable "env" {
    type        = string
    default     = "tf-dev"
    description = "Environment Name"
}

variable "enabled_cluster_log_types" {
    type        = list
    default     = ["api", "audit"]
    description = "EKS cluster logging Enabled for types"
}

variable "eks_cluster_name" {
    type        = string
    default     = "eks-cluster"
    description = "EKS Cluster Name"
}

variable "subnet_ids" {
    type        = list
    default     = []
    description = "EKS Cluster will be built-in and use Subnet ids"
}

variable "security_group_ids" {
    type        = list
    default     = []
    description = "EKS Cluster will be built-in and use Security Groups"
}

variable "eks_cluster_version" {
    type        = string
    default     = "latest"
    description = "EKS Cluster Version"
}