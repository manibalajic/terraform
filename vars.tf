variable "publiccidrs" {
  description = "public-cidrs"
  type        = list(string)
}

variable "privatecidrs" {
  description = "public-cidrs"
  type        = list(string)
}

variable "ports" {
  description = "ports"
  type        = list(string)


}


# variable "samp" {
#   description = "what"
#   type = map(object({
#     cidr_block = string
#   }))
# }

# samps = {
#   key1 = {
#     cidr_block = "10.0.3.0/24"
#   }
# }



variable "samps" {
  description = "Map of CIDR blocks"
  type = map(object({
    cidr_block = string
  }))
  default = {
    "subnet" = {
      cidr_block = "10.0.3.0/24"

    }
    subnet2 = {
      cidr_block = "10.0.4.0/24"
    }

  }
}