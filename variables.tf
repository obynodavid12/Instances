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

variable "runner_cfg_pat" {
  default = ""

}

