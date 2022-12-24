resource "cloudflare_pages_project" "site" {
  account_id        = local.cloudflare_account_id
  name              = var.name
  production_branch = var.repo_branch
}

resource "cloudflare_pages_domain" "apex" {
  account_id   = local.cloudflare_account_id
  project_name = cloudflare_pages_project.site.name
  domain       = cloudflare_record.apex.hostname

  depends_on = [
    cloudflare_pages_project.site,
    cloudflare_record.site,
  ]
}

resource "cloudflare_pages_domain" "site" {
  account_id   = local.cloudflare_account_id
  project_name = cloudflare_pages_project.site.name
  domain       = cloudflare_record.site.hostname

  depends_on = [
    cloudflare_pages_project.site,
    cloudflare_record.site,
  ]
}
