###################################
#   REQUIRED VARIABLES
###################################

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

variable "connection_string" {
  type = object({
    port = any,
    ip   = any,
  })
}

###################################
#   OPTIONAL VARIABLES
###################################

variable "code_version" {
  default = "v1.0.1"
}