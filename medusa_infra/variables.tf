variable "db_username" {
  type        = string
  description = "The username for the PostgreSQL database."
}

variable "db_password" {
  type        = string
  description = "The password for the PostgreSQL database."
  sensitive   = true
}

variable "medusa_image" {
  type        = string
  description = "The Docker image for the Medusa backend."
}

