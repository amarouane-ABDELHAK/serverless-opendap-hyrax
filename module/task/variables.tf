variable "repository_url" {
  type = string
}
variable "task_family_name" {
  type = string
  default = "ghrc-opendap"
}

variable "execution_role_arn" {}
variable "task_role_arn" {}