output "enabled_api_names" {
  description = "List of enabled APIs"
  value       = [for svc in google_project_service.enabled_apis : svc.service]
}
