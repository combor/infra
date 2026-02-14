resource "aws_iam_user" "traefik" {
  name = "traefik"
  path = "/robots/"

  tags = {
    type = "robot"
  }
}

resource "aws_iam_access_key" "traefik" {
  user = aws_iam_user.traefik.name
}

resource "aws_iam_user_policy" "traefik" {
  name = "traefik"
  user = aws_iam_user.traefik.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "route53:GetChange",
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets",
        ]
        Resource = [
          "arn:aws:route53:::hostedzone/*",
          "arn:aws:route53:::change/*",
        ]
      },
      {
        Effect   = "Allow"
        Action   = ["route53:ListHostedZonesByName", "route53:ListHostedZones"]
        Resource = "*"
      },
    ]
  })
}
