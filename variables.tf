variable "tf_github_repo" {
  description = "Terraform GitHub Repo"
  type        = string
  default     = "fvder-blvck"
}

variable "global_vars" {
  type = any
  default = {
    account_id = "1234567890"
    region     = "us-east-1"
  }
}