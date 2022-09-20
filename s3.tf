terraform {
  backend "s3" {
    bucket = "test-state-hc"
    key    = "test.tfstate"
    region = "us-east-1"
  }
}
