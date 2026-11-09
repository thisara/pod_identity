#EKS IAM
data "aws_iam_policy_document" "eks_cluster_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-cluster-role"

  path = "/terraform-managed/"
  #permissions_boundary = "arn:aws:iam::731770490737:policy/terraformProdRole-created-role-boundary"
  
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role = aws_iam_role.eks_cluster_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

#EKS WORKER NODES IAM
data "aws_iam_policy_document" "eks_node_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "eks_node_role" {
  name = "${var.cluster_name}-node-role"

  path = "/terraform-managed/"
  #permissions_boundary = "arn:aws:iam::731770490737:policy/terraformProdRole-created-role-boundary"

  assume_role_policy = data.aws_iam_policy_document.eks_node_assume_role.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role = aws_iam_role.eks_node_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_ecr_policy" {
  role = aws_iam_role.eks_node_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

# EKS CNI IAM
data "aws_iam_policy_document" "eks_pod_identity_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "eks_vpc_cni_role" {
  name = "${var.cluster_name}-vpc-cni-role"

  path = "/terraform-managed/"
  #permissions_boundary = "arn:aws:iam::731770490737:policy/terraformProdRole-created-role-boundary"

  assume_role_policy = data.aws_iam_policy_document.eks_pod_identity_assume_role.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "eks_vpc_cni_policy" {
  role = aws_iam_role.eks_vpc_cni_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}