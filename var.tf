variable "tests" {
    description = "for test"
    type = list(any)
    default = [ 1,2,3,5,10]
  
}

variable "newone" {
    description = "for maps"
    type = map(string)
    default = {
      "prod" = "t2.medium"
      "dev"    = "t2.nano"        
    }
  
}

variable "instance_type"{
}

