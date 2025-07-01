output "gke_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE cluster name"
}

output "gke_cluster_endpoint" {
  value       = google_container_cluster.primary.endpoint
  description = "GKE cluster endpoint"
}

output "gke_cluster_master_version" {
  value       = google_container_cluster.primary.master_version
  description = "Master Kubernetes version"
}
