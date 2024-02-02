// Creator: Joe Puliadi (jpuliadi@splunk.com)
// Version: 1.0
// Date: 5/1/23

variable "sfx_api_token" {
  type    = string
  description = "\nWhat's the Splunk Observability API Token?"
}

variable "sfx_realm" {
  type        = string
  description = "\nWhat's the realm for your Organization? Is it us1 or eu1 etc.?"
}

variable "urls_to_hit" {
  type        = list
  description = "\nURLs you want to test for Uptime?"
}

variable "location_ids" {
  type        = list
  description = "\nWhat locations you want this test to run at?"
}

variable "active" {
  type    = bool
  description = "\nDo you want to this test Active/Paused?"
  default = false
}

variable "frequency" {
  type    = number
  description = "\nHow frequently do you want to run the test (in mins)?"
  default = 5
}

variable "device" {
  type        = number
  description = "\nWhat's the device you want to run this test on?\n 1 = Desktop; 2 = iPad; 3 = iPhone; 4 = Samsung Galaxy"
}
