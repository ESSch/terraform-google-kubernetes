Usage
```
provider "google" {
  credentials = file("./kubernetes_key.json")
  project     = "node-cluster-243923"
  region      = "europe-west2"
}
module "kubernetes" {
  source  = "ESSch/kubernetes/google"
  version = "0.0.2"

  project_name = "node-cluster-243923"
}
```
Link: https://registry.terraform.io/modules/ESSch