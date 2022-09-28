variable "project" {
  default = "runners-eks"
}

variable "azs" {
  type = string
  description = "The availability zones for the database"
  default = "eu-central-1a,eu-central-1b"
}