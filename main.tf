provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "my-tfstate-bucket"
    key    = "path/to/my/state"
    region = "us-west-2"
  }
}
