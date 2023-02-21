variable "env" {
    type        = string
    default     = "tf-dev"
    description = "Environment Name"
}

variable "eks_cluster_name" {
    type        = string
    default     = "non-existing-eks-cluster"
    description = "EKS Cluster Name"
}

variable "eks_nodegroup_name" {
    type        = string
    default     = "non-existing-eks-cluster"
    description = "EKS Cluster NodeGroup Name"
}

variable "subnets_list" {
    type        = list
    default     = []
    description = "subnets Ids (list) where Worker/Node Groups instances created"
}

variable "ng_desired_size" {
    type        = number
    default     = 1
    description = "Desired Number of Worker/Node Groups Instances"
}

variable "ng_max_size" {
    type        = number
    default     = 1
    description = "Maximum Number of Worker/Node Groups Instances"
}

variable "ng_min_size" {
    type        = number
    default     = 1
    description = "Minimum Number of Worker/Node Groups Instances"
}

variable "ng_max_unavailable" {
    type        = number
    default     = 1
    description = "Desired max number of unavailable worker nodes during node group update"
}

variable "ng_ami_type" {
    type        = string
    default     = "AL2_x86_64"
    description = "AMI Type for Node Group Instances"
}

variable "ng_capacity_type" {
    type        = string
    default     = "ON_DEMAND"
    description = "Capacity Type for Node Group Instances"
}

variable "ng_instance_types" {
    type        = list
    default     = ["t3.medium"]
    description = "Instance Types for Node Group Instances"
}

variable "ng_disk_size" {
    type        = number
    default     = 20
    description = "Disk Size for Node Group Instances"
}