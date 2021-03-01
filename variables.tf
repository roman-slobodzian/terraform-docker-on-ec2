variable "cluster_name" {
  description = "The name to use for all the cluster resources"
  type = string
}

variable "instance_type" {
  description = "Type of the ec2 instance"
  type = string
}

variable "aws_key_pair_name" {
  description = "Name of your Key Pair. Please create it in AWS console."
}

variable "aws_key_pair_secret_key" {
  description = "Content of the private part of SSH key which should be used for remote-exec"
}
