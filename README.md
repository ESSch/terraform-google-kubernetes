The module create node cluster for Kubernetes.

### common usage
```
provider "google" {
  credentials = file("./kubernetes_key.json")
  project     = "node-cluster-243923"
  region      = "europe-west2"
}

module "kubernetes" {
  source  = "ESSch/kubernetes/google"
  version = "~>0.0.2"
}
```
Link: https://registry.terraform.io/modules/ESSch

### use in production and development space

```
provider "google" {
  alias       = "dev"
  credentials = file("./kubernetes_key.json")
  project     = "node-cluster-243923"
  region      = "europe-west2"
}

module "kubernetes_prod" {
  source  = "ESSch/kubernetes/google"
  version = "~>0.0.2"
  node_pull = false
  providers = {
    google = google.dev
  }
}
```
```
provider "google" {
  alias = "prod"
  credentials = file("./kubernetes_prod_key.json")
  project     = "node-cluster-prod-244519"
  region      = "us-west2"
}

module "kubernetes_prod" {
  source  = "ESSch/kubernetes/google"
  version = "~>0.0.2"
  providers = {
    google = google.prod
  }
}
```