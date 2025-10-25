#Output vars

output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}


output "frontend_url" {
  value = module.webapp.webapp_default_hostname
}

output "backend_url" {
  value = module.backend_webapp.webapp_default_hostname
}

output "sql_server_name" {
  value = module.sql.sql_server_name
}

output "sql_admin_username" {
  value = var.sql_admin_username
}

output "sql_admin_password" {
  value     = var.sql_admin_password
  sensitive = true
}
