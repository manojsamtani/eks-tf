resource "aws_iam_role" "EKSClusterRole" {
  name = "${var.env}-${var.eks_cluster_name}-EKSClusterRole"
  path = "/"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

/*
### OIDC IAM Policy attachment
data "tls_certificate" "eks_cluster_tls_cert" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.eks_cluster_tls_cert.certificates[*].sha1_fingerprint
  url             = data.tls_certificate.eks_cluster_tls_cert.url
}

data "aws_iam_policy_document" "eks_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks_oidc_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks_oidc_provider.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_policy" "eks_oidc_policy" {
  name        = "eks_oidc_policy"
  policy      = data.aws_iam_policy_document.eks_oidc_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy_oidc" {
  for_each   = toset([
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    aws_iam_policy.eks_oidc_policy.arn
  ])

  policy_arn = each.value
  role       = aws_iam_role.EKSClusterRole.name
}
*/

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  for_each   = toset([
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])

  policy_arn = each.value
  role       = aws_iam_role.EKSClusterRole.name
}