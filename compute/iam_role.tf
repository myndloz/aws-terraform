#--------------------------compute/iam_role.tf-----------------------

resource "aws_iam_role" "ec2_s3_access_role" {
  name = "s3-role"

  assume_role_policy = file("${path.cwd}/compute/json_files/assumerolepolicy.json")
  # {
  #   "Version": "2012-10-17",
  #   "Statement": [
  #     {
  #       "Action": "sts:AssumeRole",
  #       "Principal": {
  #         "Service": "s3.amazonaws.com"
  #       },
  #       "Effect": "Allow",
  #       "Sid": ""
  #     }
  #   ]
  # }

}



