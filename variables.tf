variable "bucket_name" {
  type        = string
  description = "The bucket name in which this module's data should be added. Must be globally unique."
}

variable "create_bucket" {
  type        = bool
  description = "Whether or not this module should create the S3 bucket in which the test file will be stored."
  default     = false
}

variable "bucket_prefix" {
  type        = string
  description = "The prefix to be used in S3 key for the object."
  default     = ""
}

