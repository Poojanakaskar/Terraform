
provider "aws" {
  version = "~> 2.28"
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}


resource "aws_instance" "main" {
  ami           = "ami-0b898040803850657"
  instance_type = "t2.small"
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket"
  acl    = "public"

  tags = {
    Name        = "bucket123"
    Environment = "Dev"
  }
}