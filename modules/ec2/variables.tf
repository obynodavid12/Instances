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
<<<<<<< HEAD
  description = "personal token to authenticate with the GitHub Repo"
=======
  description = "PAT to authenticate with the GitHub Repo"
>>>>>>> 0d562c61f52038e7016bce3d5e35f1ace978357d
  type        = string
  default     = ""
}




