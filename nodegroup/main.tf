resource "aws_eks_node_group" "node-group-ec2" {
    cluster_name    = "${var.env}-${var.eks_cluster_name}"
    node_group_name = "${var.env}-${var.eks_nodegroup_name}"
    node_role_arn   = aws_iam_role.NodeGroupRole.arn
    subnet_ids      = var.subnets_list # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME (where CLUSTER_NAME is replaced with the name of the EKS Cluster).

    scaling_config {
        desired_size = var.ng_desired_size
        max_size     = var.ng_max_size
        min_size     = var.ng_min_size
    }

    update_config {
        max_unavailable = var.ng_max_unavailable
    }

    ami_type        = var.ng_ami_type
    capacity_type   = var.ng_capacity_type
    instance_types  = var.ng_instance_types
    disk_size       = var.ng_disk_size

    # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
    # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
    depends_on = [
        aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
        aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
        aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly
    ]
}