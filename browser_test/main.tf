// Creator: Joe Puliadi (jpuliadi@splunk.com)
// Version: 1.0
// Date: 5/1/23

terraform {
  required_providers {
    synthetics = {
      source  = "splunk/synthetics"
      version = "1.0.4"
    }
  }
}

provider "synthetics" {
  product = "observability"
  realm   = var.sfx_realm
  apikey  = var.sfx_api_token
}

// Create a Browser V2 Check
resource "synthetics_create_browser_check_v2" "browser_test" {
  for_each = toset(var.urls_to_hit)
  test {
    active = var.active
    device_id = var.device
    frequency = var.frequency
    location_ids = var.location_ids
    name = "Browser Test for ${each.value} created using Terraform by Joe Puliadi"
    scheduling_strategy = "round_robin"
    url_protocol = "https://"
    start_url = each.value
    transactions {
      name = "${each.value} Transaction 1"
      steps {
        name = "${each.value} Step 1"
        type = "go_to_url"
        wait_for_nav = true
        action = "go_to_url"
        url = "${each.value}"
      }
    }
    advanced_settings {
      verify_certificates = false
      authentication {
        username = "dummy_user_name"
        password = "{{env.btjppwd}}"
        // password must follow variable format of {{env.<VARIABLE_NAME>}}","password <VARIABLE_NAME> must correspond to an existing variable name"]}}
        // "password <VARIABLE_NAME> must correspond to an existing variable name"
        # password = "{{env.beep-var}}"
      }
    }
  }    
}

/*
resource "synthetics_create_browser_check_v2" "browser_test" {
  test {
    active = true
    device_id = var.device
    frequency = var.frequency
    location_ids = ["aws-us-east-1"]
    name = "Browser Test for ${var.url_to_hit} created using Terraform by Joe Puliadi"
    scheduling_strategy = "round_robin"
    url_protocol = "https://"
    start_url = var.url_to_hit
    transactions {
      name = "Synthetic transaction 1"
      steps {
        name = "Go to URL"
        type = "go_to_url"
        url = var.url_to_hit
        action = "go_to_url"
        wait_for_nav = true
        options {
          url = var.url_to_hit
        }
      }
      steps {
        name = "New step"
        type = "click_element"
        selector_type = "id"
        wait_for_nav = false
        selector = "\"free-splunk-click-mobile\""
      }
      steps {
        name = "New step"
        type = "click_element"
        selector_type = "id"
        wait_for_nav = false
        selector = "login-button"
      }
    }
    transactions {
      name = "New synthetic transaction"
      steps {
        name = "New step"
        type = "go_to_url"
        wait_for_nav = true
        action = "go_to_url"
        url = "https://www.batman.com"
      }
    }
    advanced_settings {
      verify_certificates = false
      user_agent = "Mozilla/5.0 (X11; Linux x86_64; Splunk Synthetics) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36"
      # authentication {
        # username = "batmab"
        # password = "{{env.beep-var}}"
      # }
      headers {
        name = "superstar-machine"
        value = "\"taking it too the staaaaars\""
        domain = "asdasd.batman.com"
      }
      cookies {
        key = "sda"
        value = "sda"
        domain = "asd.com"
        path = "/asd"
      }
      cookies {
        key = "yes"
        value = "no"
        domain = "zodiak.com"
        path = "/Edlesley"
      }
      host_overrides {
        source = "asdasd.com"
        target = "whost.com"
        keep_host_header = false
      }
      host_overrides {
        source = "92.2.2.2"
        target = "91.1.1.1"
        keep_host_header = true
      }
    }
  }    
}
*/
