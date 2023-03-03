variable "domain_name" {
  type        = string
  description = "The domain name for the website."
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}

variable "common_tags" {
  description = "Common tags you want applied to all components."
}

variable "aws_glob_region" {
  type        = string
  description = "The Region you want to build infrastructure in."
}
variable "aws_account_prof" {
  type        = string
  description = "The named profile to use associated with the AWS account you want to use."
}
