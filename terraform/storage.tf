resource "google_storage_bucket" "truisms" {
  name                        = "lukwam-truisms"
  location                    = "US"
  force_destroy               = false
  uniform_bucket_level_access = true
}
