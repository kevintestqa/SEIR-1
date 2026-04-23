# add this to the root module main.tf

module "mig" {
  source = "./modules/mig"

  name        = "${local.prefix}-${var.environment}-web"
  zone        = var.zone
  network     = module.vpc.network_id
  subnetwork  = module.vpc.subnet_id

  min_replicas = 1
  max_replicas = 3
}
