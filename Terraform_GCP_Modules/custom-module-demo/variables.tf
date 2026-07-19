variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
  default     = "your-gcp-project-id"
}

variable "name" {
  description = "Name of the buckets to create."
  type        = string
  default     = "your-unique-bucket-name"
}