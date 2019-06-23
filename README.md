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
```bash
essh@kubernetes-master:~/node-cluster$ gcloud compute instances list
NAME                                    ZONE             MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP    EXTERNAL_IP     STATUS
gke-node-ks-default-pool-2e5073d4-csmg  europe-north1-a  n1-standard-1               10.166.0.2     35.228.96.97    RUNNING
gke-node-ks-node-ks-pool-ccbaf5c6-4xgc  europe-north1-a  n1-standard-1               10.166.15.233  35.228.82.222   RUNNING
gke-node-ks-default-pool-72a6d4a3-ldzg  europe-north1-b  n1-standard-1               10.166.15.231  35.228.143.7    RUNNING
gke-node-ks-node-ks-pool-9ee6a401-ngfn  europe-north1-b  n1-standard-1               10.166.15.234  35.228.129.224  RUNNING
gke-node-ks-default-pool-d370036c-kbg6  europe-north1-c  n1-standard-1               10.166.15.232  35.228.117.98   RUNNING
gke-node-ks-node-ks-pool-d7b09e63-q8r2  europe-north1-c  n1-standard-1               10.166.15.235  35.228.85.157   RUNNING
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
```

```