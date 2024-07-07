output "simple" {
    value = {for name, each in var.tests: name=> each }
  
}

output "samp" {
    value = element(var.tests,0)
  
}

output "sampss" {
  value = {for name,val in var.tests: name=> val if val > 3}
}

output "randdo" {
  value = length(var.tests) != 1 ? "mani" : "kavi"  
  
}

output "zoness" {
  value = local.zones
  
}