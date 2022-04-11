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

variable "runner_token" {
  description = "runnerl token to authenticate with the GitHub Repo"
  type        = string
  default     = ""
}




  
  

