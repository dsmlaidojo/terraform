terraform {
  required_providers {
    synthetics = {
      source  = "splunk/synthetics"
      version = "1.0.4"
    }
  }
}

resource "synthetics_create_http_check_v2" "jp_uptime_check" {
  test {
    active              = true
    frequency           = 5
    location_ids        = [
                           "aws-us-west-1",
                           "aws-ap-south-1-del-1"
                          ]
    # name                = "Uptime Test created using Terraform by Joe Puliadi"
    name                = "Uptime Test for ${var.url_to_hit} created using Terraform by Joe Puliadi"
    type                = "http"
    url                 = var.url_to_hit
    scheduling_strategy = "round_robin"
    request_method      = "GET"
    body                = null
    headers {
      name  = "uptime_test_header_1"
      value = "val_uptime_test_header_1"
    }
    headers {
      name  = "uptime_test_header_2"
      value = "val_uptime_test_header_2"
    }
  }
}

#data "synthetics_http_v2_check" "datasource_check_http" {
#    test {
#      id = 490
#    }
#}
