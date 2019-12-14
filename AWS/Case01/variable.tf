###################################
#   REQUIRED VARIABLES
###################################

variable "name" {
  type = string
}


###################################
#   OPTIONAL VARIABLES
###################################

variable "instance_type" {
  type    = string
  default = "t3.micro"
}