##############################################
# IAM User with S3FullAccess Policy
##############################################

resource "aws_iam_user" "s3_user" {
  name = "${var.project_name}-s3-user"

  tags = {
    Name        = "${var.project_name}-s3-user"
    Environment = var.environment
  }
}

resource "aws_iam_user_policy_attachment" "s3_full_access" {
  user       = aws_iam_user.s3_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
