#Security Policy

resource "google_compute_security_policy" "waf" {
  name = "${var.name}-policy"

  # Allow your IP (example)
  rule {
    priority = 1000
    action   = "allow"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = ["YOUR_IP/32"]
      }
    }

    description = "Allow trusted IP"
  }

  # Basic SQL injection protection
  rule {
    priority = 2000
    action   = "deny(403)"

    match {
      expr {
        expression = "evaluatePreconfiguredExpr('sqli-v33-stable')"
      }
    }

    description = "Block SQL injection"
  }

  # Default allow (required)
  rule {
    priority = 2147483647
    action   = "allow"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = ["*"]
      }
    }

    description = "Default allow"
  }
}

#Attach to Backend Service

resource "google_compute_backend_service" "secured_backend" {
  name          = "${var.name}-secured-backend"
  protocol      = "HTTP"
  timeout_sec   = 10
  health_checks = []

  security_policy = google_compute_security_policy.waf.id
}


resource "google_compute_security_policy" "waf" {
  name = "${var.name}-policy"

  dynamic "rule" {
    for_each = var.enable_geo_blocking && length(var.blocked_region_codes) > 0 ? [1] : []
    content {
      priority = 1000
      action   = "deny(403)"
      description = "Block selected geographies"

      match {
        expr {
          expression = "has(request.headers['host']) && origin.region_code in ['${join(\"','\", var.blocked_region_codes)}']"
        }
      }
    }
  }

  dynamic "rule" {
    for_each = var.enable_rate_limit ? [1] : []
    content {
      priority = 2000
      action   = "throttle"
      description = "Basic rate limiting"

      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = ["*"]
        }
      }

      rate_limit_options {
        conform_action = "allow"
        exceed_action  = "deny(429)"

        rate_limit_threshold {
          count        = var.rate_limit_count
          interval_sec = var.rate_limit_interval_sec
        }

        enforce_on_key = "IP"
      }
    }
  }

  dynamic "rule" {
    for_each = var.enable_waf_rules ? [1] : []
    content {
      priority = 3000
      action   = "deny(403)"
      description = "Block SQL injection"

      match {
        expr {
          expression = "evaluatePreconfiguredExpr('sqli-v33-stable', {'sensitivity': 1})"
        }
      }
    }
  }

  dynamic "rule" {
    for_each = var.enable_waf_rules ? [1] : []
    content {
      priority = 3100
      action   = "deny(403)"
      description = "Block XSS"

      match {
        expr {
          expression = "evaluatePreconfiguredExpr('xss-v33-stable', {'sensitivity': 1})"
        }
      }
    }
  }

  # Bot management placeholder:
  # enable only after reCAPTCHA Enterprise is configured
  dynamic "rule" {
    for_each = var.enable_bot_management && var.recaptcha_redirect_site_key != "" ? [1] : []
    content {
      priority = 4000
      action   = "redirect"
      description = "Bot assessment via reCAPTCHA"

      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = ["*"]
        }
      }

      redirect_options {
        type = "GOOGLE_RECAPTCHA"
      }
    }
  }

  rule {
    priority = 2147483647
    action   = "allow"
    description = "Default allow"

    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
  }
}
