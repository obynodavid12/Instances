variable "namespace" {
  type = string
}

variable "vpc" {
  type = any
}

variable key_name {
  type = string
}

variable "sg_pub_id" {
  type = any
}

variable "sg_priv_id" {
  type = any
}


variable "personal_access_token" {
  description = "personal token to authenticate with the GitHub Repo"
  type        = string
  default     = ""
}

variable "GITHUBTOKEN" {}
variable "GITHUBORG" {}
variable "REPO" {}
variable "AWS_DEFAULT_REGION" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "AWS_ACCESS_KEY_ID" {}
