###################################
#   REQUIRED VARIABLES
###################################

variable "db_config" {
  description = "This value is used to set the instance configuration"
  type = object({
    name    = string,
    db_size = string,
    env_tag = string,
  })
}

variable "vm_config" {
  description = "This value is used to set the instance configuration"
  type = object({
    name    = string,
    vm_size = string,
  })
}

variable "witelist" {
  description = "This value is used to set a list of IP which will be whitelisted"
  type        = list(any)
}

###################################
#   OPTIONAL VARIABLES
###################################

