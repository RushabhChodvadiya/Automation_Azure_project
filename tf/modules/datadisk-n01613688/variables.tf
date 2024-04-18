variable "location" {}
variable "resource_group_name" {}

variable "disk_count" {
  default = 4
}

variable "disk_size_gb" {
  default = 10
}

variable "vm_ids" {
  type    = list(string)
  default = []
}
variable "tags" {}