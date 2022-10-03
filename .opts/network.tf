module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "5.2.0"

  project_id   = var.project_id
  network_name = var.project_id
  routing_mode = "REGIONAL"
  #mtu          = 1500

  subnets = [
    {
      subnet_name   = local.subnet_01
      subnet_region = var.region
      subnet_ip     = "10.10.0.0/24"

      # Use Private Google Access
      subnet_private_access = true

      # Capture Network Logs
      subnet_flow_logs             = "true"
      subnet_flow_logs_interval    = "INTERVAL_15_MIN"
      subnet_flow_logs_sampling    = 0.9
      subnet_flow_logs_metadata    = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_filter_expr = "true"
    },
    {
      subnet_name   = local.subnet_02
      subnet_region = var.region
      subnet_ip     = "10.10.64.0/24"

      # Use Private Google Access
      subnet_private_access = true

      # Capture Network Logs
      subnet_flow_logs             = "true"
      subnet_flow_logs_interval    = "INTERVAL_15_MIN"
      subnet_flow_logs_sampling    = 0.9
      subnet_flow_logs_metadata    = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_filter_expr = "true"
    },
    {
      subnet_name   = local.subnet_03
      subnet_region = var.region
      subnet_ip     = "10.10.128.0/24"

      # Use Private Google Access
      subnet_private_access = true

      # Capture Network Logs
      subnet_flow_logs             = "true"
      subnet_flow_logs_interval    = "INTERVAL_15_MIN"
      subnet_flow_logs_sampling    = 0.9
      subnet_flow_logs_metadata    = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_filter_expr = "true"
    },
    {
      subnet_name   = local.subnet_04
      subnet_region = var.region
      subnet_ip     = "10.10.192.0/24"

      # Use Private Google Access
      subnet_private_access = true

      # Capture Network Logs
      subnet_flow_logs             = "true"
      subnet_flow_logs_interval    = "INTERVAL_15_MIN"
      subnet_flow_logs_sampling    = 0.9
      subnet_flow_logs_metadata    = "INCLUDE_ALL_METADATA"
      subnet_flow_logs_filter_expr = "true"
    },
  ]

  secondary_ranges = {
    (local.subnet_01) = [
      {
        range_name    = "${local.subnet_01}-pod"
        ip_cidr_range = "192.168.0.0/18"
      },
      {
        range_name    = "${local.subnet_01}-service"
        ip_cidr_range = "172.16.0.0/18"
      },
    ]

    (local.subnet_02) = [
      {
        range_name    = "${local.subnet_02}-pod"
        ip_cidr_range = "192.168.64.0/18"
      },
      {
        range_name    = "${local.subnet_02}-service"
        ip_cidr_range = "172.16.64.0/18"
      },
    ]

    (local.subnet_03) = [
      {
        range_name    = "${local.subnet_03}-pod"
        ip_cidr_range = "192.168.128.0/18"
      },
      {
        range_name    = "${local.subnet_03}-service"
        ip_cidr_range = "172.16.128.0/18"
      },
    ]

    (local.subnet_04) = [
      {
        range_name    = "${local.subnet_03}-pod"
        ip_cidr_range = "192.168.192.0/18"
      },
      {
        range_name    = "${local.subnet_03}-service"
        ip_cidr_range = "172.16.192.0/18"
      },
    ]
  }

  #  firewall_rules = [
  #    {
  #      name      = "allow-ssh-ingress"
  #      direction = "INGRESS"
  #      ranges    = ["0.0.0.0/0"]
  #      allow = [{
  #        protocol = "tcp"
  #        ports    = ["22"]
  #      }]
  #      log_config = {
  #        metadata = "INCLUDE_ALL_METADATA"
  #      }
  #    },
  #    {
  #      name      = "deny-udp-egress"
  #      direction = "INGRESS"
  #      ranges    = ["0.0.0.0/0"]
  #      deny = [{
  #        protocol = "udp"
  #        ports    = null
  #      }]
  #    },
  #  ]
}