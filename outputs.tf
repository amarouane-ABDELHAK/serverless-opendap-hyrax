output "alb_hostname" {
  value = "${module.alb.dns}:8080/opendap"
}
output "ecr_name" {
  value = module.opendap_ecr.sls-opendap-ecr-url.repository_url
}