terraform {
  backend "gcs" {
    bucket = "malazarevic"
    prefix = "terraform/state"
  }
}
provider "google" {
  project = var.project_id
  region  = var.region
}

# Dev Environment
resource "google_compute_network" "dev_vpc_network" {
  name = "malazarevic-dev-vpc"
}

resource "google_compute_subnetwork" "dev_public_subnet" {
  name          = var.dev_public_subnet
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.dev_vpc_network.name

  private_ip_google_access = false
}

resource "google_compute_subnetwork" "dev_private_subnet" {
  name          = var.dev_private_subnet
  ip_cidr_range = "10.0.2.0/24"
  region        = var.region
  network       = google_compute_network.dev_vpc_network.name

  private_ip_google_access = true
}

resource "google_container_cluster" "dev_cluster" {
  name     = "malazarevic-dev"
  location = var.region
  project  = var.project_id

  node_pool {
    name       = "dev-node-pool"
    node_count = 1

    node_config {
      machine_type = "n1-standard-2"
    }
  }
}

# Staging Environment
resource "google_compute_network" "staging_vpc_network" {
  name = "malazarevic-staging-vpc"
}

resource "google_compute_subnetwork" "staging_public_subnet" {
  name          = var.staging_public_subnet
  ip_cidr_range = "10.0.3.0/24"
  region        = var.region
  network       = google_compute_network.staging_vpc_network.name

  private_ip_google_access = false
}

resource "google_compute_subnetwork" "staging_private_subnet" {
  name          = var.staging_private_subnet
  ip_cidr_range = "10.0.4.0/24"
  region        = var.region
  network       = google_compute_network.staging_vpc_network.name

  private_ip_google_access = true
}

resource "google_container_cluster" "staging_cluster" {
  name     = "malazarevic-staging"
  location = var.region
  project  = var.project_id

  node_pool {
    name       = "staging-node-pool"
    node_count = 1

    node_config {
      machine_type = "n1-standard-2"
    }
  }
}

# Prod Env
resource "google_compute_network" "prod_vpc_network" {
  name = "malazarevic-prod-vpc"
}

resource "google_compute_subnetwork" "prod_public_subnet" {
  name          = var.prod_public_subnet
  ip_cidr_range = "10.0.5.0/24"
  region        = var.region
  network       = google_compute_network.prod_vpc_network.name

  private_ip_google_access = false
}

resource "google_compute_subnetwork" "prod_private_subnet" {
  name          = var.prod_private_subnet
  ip_cidr_range = "10.0.6.0/24"
  region        = var.region
  network       = google_compute_network.prod_vpc_network.name

  private_ip_google_access = true
}

resource "google_container_cluster" "prod_cluster" {
  name     = "malazarevic-prod"
  location = var.region
  project  = var.project_id

  node_pool {
    name       = "prod-node-pool"
    node_count = 1

    node_config {
      machine_type = "n1-standard-2"
    }
  }
}

resource "google_storage_bucket" "my_bucket" {
  name          = "malazarevic"
  location      = "US" 
  force_destroy = true
}