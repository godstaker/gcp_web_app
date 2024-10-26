module "gcp_vpc" {
  source = "../modules/gcp_vpc"

  vpc_name        = "gke-vpc"
  vpc_description = "for gke cluster"

  subnets = [
    {
      name                     = "subnet-1"
      ip_cidr_range            = "10.0.1.0/24"
      region                   = var.region
      private_ip_google_access = true
    },
    {
      name                     = "subnet-2"
      ip_cidr_range            = "10.0.2.0/24"
      region                   = var.region
      private_ip_google_access = false
    },
  ]
}


# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = var.project_id
  name                       = "webapp"
  region                     = var.region
  zones                      = ["europe-west2-a", "europe-west2-b"]
  network                    = module.gcp_vpc.network
  subnetwork                 = "subnet-1"
  ip_range_pods              = "webapp-01-pods"
  ip_range_services          = "webapp-01-services"
  http_load_balancing        = false
  network_policy             = false
  horizontal_pod_autoscaling = true
  filestore_csi_driver       = false
  dns_cache                  = false

  node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-medium"
      node_locations     = "europe-west2-a,europe-west2-b"
      min_count          = 1
      max_count          = 2
      local_ssd_count    = 0
      spot               = false
      disk_size_gb       = 100
      disk_type          = "pd-standard"
      image_type         = "COS_CONTAINERD"
      enable_gcfs        = false
      enable_gvnic       = false
      logging_variant    = "DEFAULT"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = "project-service-account@${var.project_id}.iam.gserviceaccount.com"
      preemptible        = false
      initial_node_count = 0
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    default-node-pool = {
      node-pool-metadata-custom-value = "webapp-node-pool"
    }
  }

  node_pools_taints = {
    all = []

    default-node-pool = [
      {
        key    = "default-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
  }

  node_pools_tags = {
    all = []

    default-node-pool = [
      "default-node-pool",
    ]
  }
  depends_on = [module.gcp_vpc]
}
### test###