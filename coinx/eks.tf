resource "aws_iam_role" "coinx-demo" {
  name = "eks-cluster-coinx-demo"

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

resource "aws_iam_role_policy_attachment" "coinx-demo-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.coinx-demo.name
}

resource "aws_eks_cluster" "coinx-demo" {
  name     = "coinx-demo"
  role_arn = aws_iam_role.coinx-demo.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.Non-prod-priv-a.id,
      aws_subnet.Non-prod-pub-a.id,
      aws_subnet.Non-prod-priv-b.id,
      aws_subnet.Non-prod-pub-b.id
    ]
  }

  depends_on = [aws_iam_role_policy_attachment.coinx-demo-AmazonEKSClusterPolicy]
}
