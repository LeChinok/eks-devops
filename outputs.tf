output "cluster-name" {
  value = aws_eks_cluster.gitlab-runners-cluster.name
}

output "cluster-arn" {
  value = aws_eks_cluster.gitlab-runners-cluster.arn
}

output "cluster-openid-url" {
  value = aws_eks_cluster.gitlab-runners-cluster.identity[0].oidc[0].issuer
}

output "cluster_endpoint" {
  value = aws_eks_cluster.gitlab-runners-cluster.endpoint
}
output "cluster_ca_certificate" {
  value = aws_eks_cluster.gitlab-runners-cluster.certificate_authority[0].data
}