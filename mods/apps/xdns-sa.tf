/*
  --------------------------------------------------------|-------------------------------------------------------------
                                              ExternalDNS Service Account
  ----------------------------------------------------------------------------------------------------------------------
*/
### Create a new service account for Cloud DNS admin role
### REF: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "xdns_sa" {
  account_id   = var.xdnsSA
  display_name = "ExternalDNS Admin"
  description  = "Service Account for ExternalDNS cross-project access"
}

### Bind the role 'dns.admin' to the newly created service account
### REF: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_binding
resource "google_project_iam_binding" "xdns_sa_bind" {
  project = var.project_id
  role    = "roles/dns.admin"

  members = [
    "serviceAccount:${google_service_account.xdns_sa.email}",
  ]
}

### Download the secret key file for your service account
resource "google_service_account_key" "xdns_auth_key" {
  service_account_id = google_service_account.xdns_sa.name
}

resource "kubernetes_secret" "google-application-credentials" {
  metadata {
    name = var.xdnsSA
  }
  data = {
    "${var.xdnsSA}-key.json" = base64decode(google_service_account_key.xdns_auth_key.private_key)
  }
}
