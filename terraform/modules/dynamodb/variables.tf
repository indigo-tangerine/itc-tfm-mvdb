variable "table_name" {}

variable "billing_mode" {
  default = "PAY_PER_REQUEST"
}

variable "hash_key" {
  default = "year"
}
variable "range_key" {
  default = "title"
}

variable "hash_key_type" {
  default = "N"
}
variable "range_key_type" {
  default = "S"
}
