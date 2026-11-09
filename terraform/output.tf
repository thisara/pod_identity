output "bucket_name" {
  value = aws_s3_bucket.app_files.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.app_files.arn
}

/*output "iam_user_name" {
  value = aws_iam_user.app_user.name
}
###
output "iam_user_arn" {
  value = aws_iam_user.app_user.arn
}*/

output "vpc_id" {
  description = "Created VPC ID"
  value       = aws_vpc.file_api_vpc.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = aws_subnet.private_subnets[*].id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.file_api_igw.id
}

output "public_route_table_id" {
  value = aws_route_table.public_rt.id
}

output "private_route_table_id" {
  value = aws_route_table.private_rt.id
}

#--EKS

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.main.name
}

output "eks_cluster_arn" {
  description = "EKS cluster ARN"
  value       = aws_eks_cluster.main.arn
}

output "eks_cluster_endpoint" {
  description = "Kubernetes API endpoint"
  value       = aws_eks_cluster.main.endpoint
}

output "eks_cluster_version" {
  description = "Kubernetes version"
  value       = aws_eks_cluster.main.version
}

output "eks_cluster_security_group_id" {
  description = "EKS managed cluster security group"
  value       = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
}

output "eks_cluster_role_arn" {
  description = "EKS cluster IAM role ARN"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role_arn" {
  description = "EKS worker node IAM role ARN"
  value       = aws_iam_role.eks_node_role.arn
}

output "eks_node_group_name" {
  description = "Managed node group name"
  value       = aws_eks_node_group.private_nodes.node_group_name
}

output "eks_node_group_status" {
  description = "Managed node group status"
  value       = aws_eks_node_group.private_nodes.status
}

output "eks_vpc_cni_role_arn" {
  description = "IAM role used by VPC CNI"
  value       = aws_iam_role.eks_vpc_cni_role.arn
}
