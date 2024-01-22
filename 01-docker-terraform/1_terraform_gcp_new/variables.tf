variable "credentials" {
  description = "My Credentials"
  default     = "./key/terraform-demo-412016-0456f6c3e56e.json"
}



variable "project" {
  description = "Project"
  default     = "terraform-demo-412016"
}

variable "region" {
  description = "region"
  default     = "us-central1"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset"
}

variable "location" {
  description = "Project Location"
  default     = "US"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "terraform-demo-412016-terra-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}

