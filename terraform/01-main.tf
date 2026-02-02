module "datalake_s3" {
  source      = "./modules/s3_datalake"
  bucket_name = var.datalake_bucket_name
  project     = var.project_name
  env         = var.environment
}

module "iam_roles" {
  source           = "./modules/iam_roles"
  bucket_arn       = module.datalake_s3.bucket_arn
  bucket_name      = module.datalake_s3.bucket_name
  project          = var.project_name
  env              = var.environment
}
