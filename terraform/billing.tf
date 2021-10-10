data "google_billing_account" "default" {
  display_name = var.billing_account_display_name
  open         = true
}

output "billing_account_name" {
  value = data.google_billing_account.default.id
}
