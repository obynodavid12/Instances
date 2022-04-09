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


variable "github_user" {
  description = "github user name"
  type        = string
<<<<<<< HEAD
}

variable "github_repo" {
  description = "github repo"
  type        = string
}
=======
  default     = ""
}  
  
>>>>>>> a150527d03164c9b604eede24099794841006f2c
