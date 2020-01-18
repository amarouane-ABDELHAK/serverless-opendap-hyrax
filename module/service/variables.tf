variable "service_subnet_ids" {}
variable "security_group_ids" {
  type = list(string)
}
variable "cluster_name" {}
variable "task_definition_arn" {}

variable "target_group_arn" {}

variable "container_name" {}

variable "res_depends_on" {}

variable "new_target_group_arn" {}