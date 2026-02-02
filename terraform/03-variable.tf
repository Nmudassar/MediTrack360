variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "project_name" {
  type    = string
  default = "hospital"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "datalake_bucket_name" {
  type = string
}
