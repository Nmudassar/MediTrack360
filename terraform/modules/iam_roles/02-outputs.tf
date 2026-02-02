output "airflow_role_arn" {
  value = aws_iam_role.airflow_role.arn
}

output "redshift_role_arn" {
  value = aws_iam_role.redshift_role.arn
}
