provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "my-tfstate-bucket"
    key    = "path/to/my/state"
    region = "us-west-2"
  }
}

resource "aws_eks_cluster" "example" {
  name     = "example"
  role_arn = aws_iam_role.example.arn
}

resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = <<EOF
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
EOF
}

resource "aws_iam_role_policy" "example" {
  name = "example"
  role = aws_iam_role.example.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:*",
        "ec2:*",
        "elasticloadbalancing:*"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
