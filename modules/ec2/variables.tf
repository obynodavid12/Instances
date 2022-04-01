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


variable "github_repo_url" {
  description = "The GitHub Repo URL for which the GitHub Runner to be registered with"
  type        = string
  default     = ""
}

variable "personal_access_token" {
  description = "The GitHub Repo Pat Token that would be used by the GitHub Runner to authenticate with the GitHub Repo"
  type        = string
  default     = ""
}

variable "runner_name" {
  description = "The name to give to the GitHub Runner so you can easily identify it"
  type        = string
  default     = ""
}

variable "labels" {
  description = "A list of additional labels to attach to the runner instance"
  type        = string
  default     = ""
  
}
