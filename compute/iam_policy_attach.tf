
resource "aws_iam_policy_attachment" "s3_policy_attach_to_iam_role" {
  name       = "s3-policy-attachment"
  roles      = ["${aws_iam_role.ec2_s3_access_role.name}"]
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

