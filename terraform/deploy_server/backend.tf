terraform {
  backend "s3" {
    encrypt        = true
    bucket         = "terraform-state-jotaay-deploy-server"
    key            = "terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "terraform-state-jotaay-deploy-server-lock"
  }
}

resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket        = "terraform-state-jotaay-deploy-server"
  acl           = "private"
  force_destroy = false

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "terraform-state" {
  name           = "terraform-state-jotaay-deploy-server-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags {
    Name = "Deploy Server Terraform State Lock DynamoDB Table"
  }
}
