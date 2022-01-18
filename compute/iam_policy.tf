

resource "aws_iam_policy" "s3_access_policy" {
  name        = "s3-policy"
  description = "Policy to access S3 buckets"
  policy      = file("${path.cwd}/compute/json_files/policy_s3_bucket.json")
}

