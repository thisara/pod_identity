variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}
variable "s3_iam_user" {
    description = "S3 IAM User"
    type = string
}
variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "file-api-vpc"
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)

  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}
variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)

  default = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]
}
variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)

  default = [
    "ap-southeast-2a",
    "ap-southeast-2b"
  ]
}

#EKS
variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "file-api-eks"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.34"
}

variable "node_group_name" {
  description = "EKS managed node group name"
  type        = string
  default     = "file-api-managed-nodes"
}

variable "node_instance_types" {
  description = "EC2 instance types for EKS worker nodes"
  type        = list(string)
  default     = ["t3.large"]
}

variable "node_capacity_type" {
  description = "ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition = contains(
      ["ON_DEMAND", "SPOT"],
      var.node_capacity_type
    )

    error_message = "Capacity type must be ON_DEMAND or SPOT."
  }
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 2
}

variable "node_disk_size" {
  description = "Worker node root volume size in GiB"
  type        = number
  default     = 50
}

variable "endpoint_private_access" {
  description = "Enable private Kubernetes API endpoint"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public Kubernetes API endpoint"
  type        = bool
  default     = false
}

variable "cluster_log_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Common tags for AWS resources"
  type        = map(string)

  default = {
    Project     = "file-api"
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

variable "iam_assume_role" {
  description = "Role to be assumed for installations"
  type = string
}