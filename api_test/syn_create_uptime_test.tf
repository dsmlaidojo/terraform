variable "sfx_api_token" {
    type = string
}

variable "sfx_realm" {
    type = string
    description = "\nWhat's the realm for your Organization? Is it us1 or eu1 etc.?"
}

variable "url_to_hit" {
    type = string
    description = "\nWhat's the URL you want to test for Uptime?"
}

provider "synthetics" {
    product = "observability"
    realm = "${var.sfx_realm}"
    apikey = "${var.sfx_api_token}"
}

resource "synthetics_create_http_check_v2" "jp_uptime_check" {
    test {
        active = true
        frequency = 5
        location_ids = ["aws-us-west-1", "aws-us-east-1"]
        name = "Uptime Test created using Terraform by Joe Puliadi"
        type = "http"
        url = "${var.url_to_hit}"
        scheduling_strategy = "round_robin"
        request_method = "GET"
        body = null
        headers {
            name = "uptime_test_header_1"
            value = "val_uptime_test_header_1"
        }
        headers {
            name = "uptime_test_header_2"
            value = "val_uptime_test_header_2"
        }
    }
}

output "jp_uptime_check" {
    value =  synthetics_create_http_check_v2.jp_uptime_check
}

#data "synthetics_http_v2_check" "datasource_check_http" {
#    test {
#      id = 490
#    }
#}
#
#output "datasource_check_http" {
#    value = data.synthetics_http_v2_check.datasource_check_http
#}
#
