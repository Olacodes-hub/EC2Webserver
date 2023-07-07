terraform {
  backend "s3" {
    bucket  = "safo-terraform-remote-state"
    key     = "terraform-tfstate"
    region  = "us-east-1"
    profile = "terraform-user"
  }
}
