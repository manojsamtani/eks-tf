resource "aws_eks_cluster" "eks_cluster" {
  name                      = "${var.env}-${var.eks_cluster_name}"
  role_arn                  = aws_iam_role.EKSClusterRole.arn
  version                   = var.eks_cluster_version
  enabled_cluster_log_types = var.enabled_cluster_log_types

  vpc_config {
    subnet_ids          = var.subnet_ids            # must be a list
    security_group_ids  = var.security_group_ids    # must be a list
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy
  ]
}