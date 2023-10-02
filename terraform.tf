terraform {
  required_providers {
    lacework = {
      source = "lacework/lacework"
    }
  }
}

provider "lacework" {
  account    = "msg.lacework.net"
  api_key    = "<KEY_ID>"
  api_secret = "<KEY_SECRET>"
}

provider "aws" {}

module "aws_config" {
  source  = "lacework/config/aws"
  version = "~> 0.1"
}

module "aws_cloudtrail" {
  source  = "lacework/cloudtrail/aws"
  version = "~> 2.0"
}

module "lacework_aws_agentless_scanning_global" {
  source  = "lacework/agentless-scanning/aws"
  version = "~> 0.5"

  global                    = true
  lacework_integration_name = "agentless_from_terraform"
}

#One per region
module "lacework_aws_agentless_scanning_region" {
  source  = "lacework/agentless-scanning/aws"
  version = "~> 0.5"

  regional                = true
  global_module_reference = module.lacework_aws_agentless_scanning_global
}
