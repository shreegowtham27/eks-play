resource "aws_eks_node_group" "coinx-node-group" {
  cluster_name    = aws_eks_cluster.coinx-demo.name
  node_group_name = "coinx-demo-node-group"
  node_role_arn   = aws_iam_role.eksNodeGroup.arn
  subnet_ids      = [aws_subnet.Non-prod-pub-a.id,
      aws_subnet.Non-prod-pub-b.id]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.coinx-demo-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.coinx-demo-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.coinx-demo-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_iam_role" "eksNodeGroup" {
  name = "eks-node-group"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "coinx-demo-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eksNodeGroup.name
}

resource "aws_iam_role_policy_attachment" "coinx-demo-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eksNodeGroup.name
}

resource "aws_iam_role_policy_attachment" "coinx-demo-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eksNodeGroup.name
}