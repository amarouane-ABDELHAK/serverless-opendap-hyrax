output "alb_hostname" {
  value = module.alb.dns
}
output "ecr_name" {
  value = module.opendap_ecr.sls-opendap-ecr-url.repository_url
}