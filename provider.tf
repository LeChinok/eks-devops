
//AWS_DEFAULT_REGION <- w/o alias, profile
//https://github.com/hashicorp/terraform-provider-aws/issues/9989#issuecomment-557634793
provider "aws" {
  region  = "eu-central-1"
}
provider "aws" {
  alias   = "eu-west-1"
  region  = "eu-west-1"
}
terraform {
  required_version = "= 1.1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }
  #bucket, key, region and dynamodb_table are provided with the Makefile
  backend "s3" {
    bucket = "terraform-state-705359868669"
    key     = "gitlab-eks/gitlabrunner_eks.tfstate"
    region  = "eu-west-1"
  }
}

data "terraform_remote_state" "service-vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-state-705359868669"
    region = "eu-west-1"
    key    = "production-service-vpc.tfstate"
  }
}
