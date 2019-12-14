###################################
#   REQUIRED VARIABLES
###################################

variable "vm_config" {
  type = object({
    name    = string,
    vm_size = string,
  })
}

###################################
#   OPTIONAL VARIABLES
###################################
