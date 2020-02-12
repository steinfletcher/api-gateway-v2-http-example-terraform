
resource "aws_cloudformation_stack" "api_endpoint" {
  count         = length(var.endpoints)
  name          = var.endpoints[count.index].function_name
  template_body = file("${path.module}/api.yml")
  parameters = {
    FunctionName = var.endpoints[count.index].function_name
    ApiId        = var.api_id
    RouteKey     = var.endpoints[count.index].route
  }
}
