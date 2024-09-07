terraform {
  backend "s3" {
    bucket = "terra-bucket-23"
    key = "tool-config/terraform.tfstate"
    region = "us-east-1"
  }
}