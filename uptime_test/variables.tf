variable "sfx_api_token" {
  type    = string
  #default = ""
}

variable "sfx_realm" {
  type        = string
  #default     = ""
  description = "\nWhat's the realm for your Organization? Is it us1 or eu1 etc.?"
}

variable "url_to_hit" {
  type        = string
  #default     = ""
  description = "\nWhat's the URL you want to test for Uptime?"
}
