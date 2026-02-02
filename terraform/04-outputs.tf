output "datalake_bucket_name" {
  value = module.datalake_s3.bucket_name
}

output "airflow_role_arn" {
  value = module.iam_roles.airflow_role_arn
}

output "redshift_role_arn" {
  value = module.iam_roles.redshift_role_arn
}
