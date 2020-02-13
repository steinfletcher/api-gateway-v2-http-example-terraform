locals {
  api_name = "my-api"
}

data "aws_cloudformation_export" api_id {
  name = "${local.api_name}-ApiId"
}

module "api_gw" {
  source          = "./api_gateway"
  domain_name     = "api.blah.com"
  name            = local.api_name
  api_mapping_key = "api"
}

module "endpoints" {
  source = "./api_gateway_endpoint"
  api_id = data.aws_cloudformation_export.api_id.value
  endpoints = [
    {
      route         = "GET /user/{id}"
      function_name = "get_user" // need to create a lambda function here
    },
    {
      route         = "POST /user/{id}"
      function_name = "create_user"
    }
  ]
}
