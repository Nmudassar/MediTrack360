data "aws_iam_policy_document" "assume_role_ec2" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# NOTE:
# If you're using MWAA (Managed Airflow), the trust policy is DIFFERENT.
# This is a good starter for Airflow running on EC2/EKS later.
resource "aws_iam_role" "airflow_role" {
  name               = "${var.project}-${var.env}-airflow-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_ec2.json
}

resource "aws_iam_role" "redshift_role" {
  name = "${var.project}-${var.env}-redshift-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "redshift.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}

resource "aws_iam_policy" "datalake_policy" {
  name   = "${var.project}-${var.env}-datalake-s3-policy"
  policy = data.aws_iam_policy_document.s3_access.json
}

resource "aws_iam_role_policy_attachment" "airflow_attach" {
  role       = aws_iam_role.airflow_role.name
  policy_arn = aws_iam_policy.datalake_policy.arn
}

resource "aws_iam_role_policy_attachment" "redshift_attach" {
  role       = aws_iam_role.redshift_role.name
  policy_arn = aws_iam_policy.datalake_policy.arn
}
