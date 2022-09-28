resource "aws_eks_node_group" "node-group-runners" {
  count           = length(data.terraform_remote_state.service-vpc.outputs.private_subnets)
  cluster_name    = aws_eks_cluster.gitlab-runners-cluster.name
  node_group_name = "${var.project}-${element(split(",", var.azs), count.index)}"
  node_role_arn   = aws_iam_role.node-runners.arn
  subnet_ids      = flatten([data.terraform_remote_state.service-vpc.outputs.private_subnets, data.terraform_remote_state.service-vpc.outputs.public_subnets])

  launch_template {
    id      = aws_launch_template.gitlab-runners.id
    version = aws_launch_template.gitlab-runners.default_version
  }

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

}

resource "aws_launch_template" "gitlab-runners" {
  name          = var.project
  instance_type = "t3.medium"

  tag_specifications {
    resource_type = "instance"

    tags = {
      "plista-squad" = "SELFSV"
    }
  }
}

