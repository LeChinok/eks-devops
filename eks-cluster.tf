resource "aws_eks_cluster" "gitlab-runners-cluster" {
    name = "gitlab-runners-cluster"
    role_arn = aws_iam_role.gitlab-cluster.arn
    vpc_config {
        subnet_ids = flatten([data.terraform_remote_state.service-vpc.outputs.private_subnets, data.terraform_remote_state.service-vpc.outputs.public_subnets])
        security_group_ids = [aws_security_group.eks_cluster.id]
        endpoint_private_access = true
        endpoint_public_access = true
        public_access_cidrs = ["0.0.0.0/0"]
    }

  tags = {
    Name = "${var.project}-cluster-sg"
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}