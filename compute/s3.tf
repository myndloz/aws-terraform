#--------------------------compute/s3.tf-----------------------

resource "aws_s3_bucket" "s3_grtz_bucket" {
  bucket = "s3-grtz-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
} #resource
























