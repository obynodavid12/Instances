variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  default     = "DEV-TEST"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-east-2"
  type        = string
}

variable "personal_access_token" {
  default = ""

}

variable "github_user" {
  description = "github user name"
  type        = string
  default     = "obynodavid12"
}

variable "github_repo" {
  description = "Repo name"
  type  = string
  default  = "Instances"
}


