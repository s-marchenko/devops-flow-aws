module "db" {
  source    = "../modules/db"
  db_config = var.db_config
}

module "vm" {
  source            = "../modules/vm"
  vm_config         = var.vm_config
  witelist          = var.witelist
  connection_string = { port : split(":", module.db.db_endpoint)[1], ip : split(":", module.db.db_endpoint)[0] }
}