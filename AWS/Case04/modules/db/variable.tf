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

###################################
#   OPTIONAL VARIABLES
###################################

