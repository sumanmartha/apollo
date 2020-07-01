variable "public_key" {
  default = "TestKeyPair.pub"
}

variable "private_key" {
  default = "TestKeyPair"
}

variable "ansible_user" {
  default = "ubuntu"
}

variable "project_id" {
  default = "sturdy-mode-282002"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

variable "gke_username" {
  default     = "sumanmartha"
  description = "gke username"
}

variable "gke_password" {
  default     = "sumanmartha_1234"
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 1
  description = "number of gke nodes"
}