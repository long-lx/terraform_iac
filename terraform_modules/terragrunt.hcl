remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "terraform-s3-state-techmaster-2021-devops-long"
    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}