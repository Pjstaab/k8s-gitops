resource "cloudflare_access_application" "kubernetes_cluster_access" {
  app_launcher_visible       = true
  auto_redirect_to_identity  = false
  domain                     = var.kubernetes_cluster_api
  enable_binding_cookie      = false
  http_only_cookie_attribute = false
  name                       = "Kubernetes Cluster Access"
  session_duration           = var.session_duration
  skip_interstitial          = true
  type                       = "self_hosted"
  zone_id                    = data.cloudflare_zone.domain.id
  cors_headers {
    allow_all_methods = true
    allow_all_origins = true
    allowed_methods   = ["CONNECT", "TRACE", "GET", "HEAD", "POST", "PATCH", "PUT", "OPTIONS", "DELETE"]
  }
}

resource "cloudflare_zone_settings_override" "raspbernetes_com" {
  zone_id = data.cloudflare_zone.domain.id
  settings {
    always_online             = "off"
    always_use_https          = "on"
    automatic_https_rewrites  = "on"
    brotli                    = "on"
    browser_cache_ttl         = 1800
    browser_check             = "on"
    cache_level               = "aggressive"
    challenge_ttl             = 1800
    cname_flattening          = "flatten_at_root"
    development_mode          = "off"
    early_hints               = "off"
    email_obfuscation         = "on"
    filter_logs_to_cloudflare = "off"
    hotlink_protection        = "on"
    http2                     = "on"
    http3                     = "on"
    ip_geolocation            = "on"
    ipv6                      = "on"
    log_to_cloudflare         = "on"
    max_upload                = 100
    min_tls_version           = "1.2"
    minify {
      css  = "off"
      html = "off"
      js   = "off"
    }
    mirage                      = "off"
    opportunistic_encryption    = "on"
    opportunistic_onion         = "on"
    orange_to_orange            = "off"
    origin_error_page_pass_thru = "off"
    polish                      = "off"
    prefetch_preload            = "off"
    privacy_pass                = "on"
    proxy_read_timeout          = "100"
    pseudo_ipv4                 = "add_header"
    response_buffering          = "off"
    rocket_loader               = "on"
    security_header {
      enabled            = true
      include_subdomains = true
      max_age            = 15552000
      nosniff            = true
      preload            = true
    }
    security_level              = "medium"
    server_side_exclude         = "on"
    sort_query_string_for_cache = "off"
    ssl                         = "full"
    tls_1_3                     = "zrt"
    tls_client_auth             = "off"
    true_client_ip_header       = "off"
    visitor_ip                  = "on"
    waf                         = "off"
    webp                        = "off"
    websockets                  = "on"
    zero_rtt                    = "on"
  }
}

resource "cloudflare_argo" "terraform_managed_resource_smart_routing" {
  smart_routing  = "on"
  tiered_caching = "on"
  zone_id        = data.cloudflare_zone.domain.id
}

resource "cloudflare_filter" "waf_geoip_country_filter" {
  expression = "(not ip.geoip.country in {\"AU\" \"US\"})"
  paused     = false
  zone_id    = data.cloudflare_zone.domain.id
}

resource "cloudflare_filter" "waf_badbots_filter" {
  expression = "(http.user_agent contains \"Yandex\") \nor (http.user_agent contains \"muckrack\") \nor (http.user_agent contains \"Qwantify\") \nor (http.user_agent contains \"Sogou\") \nor (http.user_agent contains \"BUbiNG\") \nor (http.user_agent contains \"knowledge\") \nor (http.user_agent contains \"CFNetwork\") \nor (http.user_agent contains \"Scrapy\") \nor (http.user_agent contains \"SemrushBot\") \nor (http.user_agent contains \"AhrefsBot\") \nor (http.user_agent contains \"Baiduspider\") \nor (http.user_agent contains \"python-requests\") \nor ((http.user_agent contains \"crawl\") \nor (http.user_agent contains \"Crawl\") \nor (http.user_agent contains \"bot\" and not http.user_agent contains \"bingbot\" and not http.user_agent contains \"Google\" and not http.user_agent contains \"Twitter\")\nor (http.user_agent contains \"Bot\" and not http.user_agent contains \"Google\") \nor (http.user_agent contains \"Spider\") \nor (http.user_agent contains \"spider\") \nand not cf.client.bot)"
  paused     = false
  zone_id    = data.cloudflare_zone.domain.id
}

resource "cloudflare_filter" "waf_high_threat_score_filter" {
  expression = "(cf.threat_score gt 1)"
  paused     = false
  zone_id    = data.cloudflare_zone.domain.id
}

resource "cloudflare_ruleset" "zone_waf_ruleset" {
  kind    = "zone"
  name    = "default"
  phase   = "http_request_firewall_custom"
  zone_id = data.cloudflare_zone.domain.id
  rules {
    action      = "block"
    description = "High Threat Level Protection"
    enabled     = true
    expression  = cloudflare_filter.waf_high_threat_score_filter.expression
  }
  rules {
    action      = "block"
    description = "Block Bad Bots"
    enabled     = true
    expression  = cloudflare_filter.waf_badbots_filter.expression
  }
  rules {
    action      = "block"
    description = "GEOIP Rule"
    enabled     = true
    expression  = cloudflare_filter.waf_geoip_country_filter.expression
  }
}

resource "cloudflare_firewall_rule" "terraform_managed_resource_11c81dab13934a94b799023b7025a2bf" {
  action      = "block"
  description = "High Threat Level Protection"
  filter_id   = cloudflare_filter.waf_high_threat_score_filter.id
  paused      = false
  zone_id     = data.cloudflare_zone.domain.id
}

resource "cloudflare_firewall_rule" "terraform_managed_resource_f1d27e26ca5e4943a570ee1e789c75f8" {
  action      = "block"
  description = "Block Bad Bots"
  filter_id   = cloudflare_filter.waf_badbots_filter.id
  paused      = false
  zone_id     = data.cloudflare_zone.domain.id
}

resource "cloudflare_firewall_rule" "terraform_managed_resource_67142a92e1ff42938cd9604ea17b9429" {
  action      = "block"
  description = "GEOIP Rule"
  filter_id   = cloudflare_filter.waf_geoip_country_filter.id
  paused      = false
  zone_id     = data.cloudflare_zone.domain.id
}

resource "cloudflare_rate_limit" "zone_rate_limit" {
  description = "Rate Limit Protection"
  period      = 10
  threshold   = 5000
  zone_id     = data.cloudflare_zone.domain.id
  action {
    mode    = "ban"
    timeout = 3600
  }
  match {
    request {
      methods     = ["_ALL_"]
      schemes     = ["_ALL_"]
      url_pattern = "*"
    }
    response {
      headers = [{
        name  = "Cf-Cache-Status"
        op    = "ne"
        value = "HIT"
      }]
      origin_traffic = true
    }
  }
}
