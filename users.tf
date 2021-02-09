resource "aws_iam_user" "traefic" {
  name = "traefic"
  path = "/robots/"

  tags = {
    type = "robot"
  }
}

resource "aws_iam_access_key" "traefic" {
  user = aws_iam_user.traefic.name
}

resource "aws_iam_user_policy" "traefic" {
  name = "traefic"
  user = aws_iam_user.traefic.name

  policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
       {
           "Sid": "",
           "Effect": "Allow",
           "Action": [
               "route53:GetChange",
               "route53:ChangeResourceRecordSets",
               "route53:ListResourceRecordSets"
           ],
           "Resource": [
               "arn:aws:route53:::hostedzone/*",
               "arn:aws:route53:::change/*"
           ]
       },
       {
           "Sid": "",
           "Effect": "Allow",
           "Action": "route53:ListHostedZonesByName",
           "Resource": "*"
       }
   ]
}
EOF
}
