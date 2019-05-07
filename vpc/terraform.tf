terraform {
  backend "s3" {
    encrypt = true
    bucket  = "fabienbucket"
    region  = "eu-west-1"
    key     = "terraform-config/terraform.tfstate"
  }
}
