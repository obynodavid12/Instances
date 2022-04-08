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


variable "RUNNER_CFG_PAT" {
  description = "personal token to authenticate with the GitHub Repo"
  type        = string
  default     = ""
}



