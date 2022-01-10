
terraform {
  cloud {
    organization = "terra-reloaded"

    workspaces {
      name = "grtz-dev"
    }
  }
}