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
  type = string
  description = "The GitHub Personal token that would be used by the GitHub Runner to authenticate with GitHub Repo"
  default = ""  
}
