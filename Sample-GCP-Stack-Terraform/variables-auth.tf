# Google Cloud connection & authentication and Application configuration | variables-auth.tf

# GCP authentication file
variable "gcp_auth_file" {
  type = string
  description = "Enter GCP auth filename"
}

# define GCP project name
variable "app_project" {
  type = string
  description = "Enter GCP project name"
}

# define application name
variable "app_name" {
  type = string
  description = "Enter the Application name"
}

# define application domain
variable "app_domain" {
  type = string
  description = "Enter the Application domain name"
}

# define application environment
variable "app_environment" {
  type = string
  description = "Enter the Application environment"
}

variable "app_node_count" {
  type = string
  description = "Enter the Number of servers to build"
}
