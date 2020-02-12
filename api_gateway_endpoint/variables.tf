variable "endpoints" {
  type = list(object({ route = string, function_name = string }))
}

variable "api_id" {
  type = string
}
