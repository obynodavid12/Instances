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


variable "PERSONAL_ACCESS_TOKEN" {
  description = "personal token to authenticate with the GitHub Repo"
  type        = string
  default     = ""
}




  
  

