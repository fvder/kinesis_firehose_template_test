locals {
  tags_all_envs = {
    "PRODUCTION" : { "Project" : "Deployment", "Environment" : "Production" },
    "DEVELOPMENT" : { "Project" : "Development", "Environment" : "Development" },
    "DEV" : { "Project" : "Development", "Environment" : "Dev" }
  }

  global_vars = merge(
    var.global_vars,
    local.kms_key_arns,
  )

  kms_key_arns = {
    Test_PoC : data.aws_kms_alias.Test_PoC.target_key_arn
  }
}

