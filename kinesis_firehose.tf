module "kinesis_firehose" {
  source = "git::https://github.com/fvder/terraform-aws-kinesis-firehose"

  for_each = local.all_user_kinesis_firehoses

  create                                = each.value.create
  destination                           = each.value.destination
  name                                  = each.value.name
  input_source                          = each.value.input_source
  kinesis_source_stream_arn             = each.value.kinesis_source_stream_arn
  kinesis_source_use_existing_role      = each.value.kinesis_source_use_existing_role
  firehose_role                         = each.value.firehose_role
  enable_sse                            = each.value.enable_sse
  sse_kms_key_arn                       = each.value.sse_kms_key_arn
  sse_kms_key_type                      = each.value.sse_kms_key_type
  create_role                           = each.value.create_role
  tags                                  = each.value.tags
  buffering_size                        = each.value.buffering_size
  buffering_interval                    = each.value.buffering_interval
  enable_lambda_transform               = each.value.enable_lambda_transform
  transform_lambda_arn                  = each.value.transform_lambda_arn
  s3_bucket_arn                         = each.value.s3_bucket_arn
  s3_prefix                             = each.value.s3_prefix
  s3_error_output_prefix                = each.value.s3_error_output_prefix
  enable_s3_encryption                  = each.value.enable_s3_encryption
  s3_kms_key_arn                        = each.value.s3_kms_key_arn
  s3_compression_format                 = each.value.s3_compression_format
  enable_dynamic_partitioning           = each.value.enable_dynamic_partitioning
  dynamic_partitioning_retry_duration   = each.value.dynamic_partitioning_retry_duration
  vpc_subnet_ids                        = each.value.vpc_subnet_ids
  enable_vpc                            = each.value.enable_vpc
  vpc_security_group_destination_vpc_id = each.value.vpc_security_group_destination_vpc_id
  vpc_security_group_tags               = each.value.vpc_security_group_tags
  role_name                             = each.value.role_name
  policy_name                           = each.value.policy_name
  role_description                      = each.value.role_description
  role_path                             = each.value.role_path
  role_force_detach_policies            = each.value.role_force_detach_policies
  role_permissions_boundary             = each.value.role_permissions_boundary
  role_tags                             = each.value.role_tags
  policy_path                           = each.value.policy_path
  cw_log_retention_in_days              = each.value.cw_log_retention_in_days
  cw_tags                               = each.value.cw_tags
}

data "aws_kms_alias" "Test_PoC" {
  name = "alias/Test_PoC"
}


#Parse User Inputs
locals {
  default_config_kinesis_firehose = { default : "${path.root}/default_configs/kinesis_firehose.json" }
  kinesis_firehose_default_config = jsondecode(templatefile(local.default_config_kinesis_firehose["default"], local.global_vars))
  all_user_kinesis_firehoses = merge(
    local.prefill_user_kinesis_firehoses
  )

  prefill_user_kinesis_firehoses = {
    for resource, config in local.user_kinesis_firehoses : lower(resource) => merge(
      local.kinesis_firehose_default_config,
      config,
      {
        resource_name : lower(config["resource_name"])
        kms_encryption_key_arn : lookup(config, "kms_encryption_key_arn", data.aws_kms_alias.Test_PoC.target_key_arn)
        tags : merge(lookup(config, "tags_extra", {}), local.tags_all_envs[upper(config["edp_environment"])], { terraform_project : var.tf_github_repo })
      }
    ) if lookup(config, "deploy", false)
  }
}

#User Inputs

locals {
  user_kinesis_firehoses = {
    kinesis_firehose_1 = {
      deploy                                = true
      edp_environment                       = "dev"
      resource_name                         = "test"
      create                                = true
      name                                  = "example-firehose1"
      input_source                          = "direct-put"
      kinesis_source_stream_arn             = ""
      kinesis_source_use_existing_role      = false
      firehose_role                         = null
      enable_sse                            = false
      sse_kms_key_arn                       = null
      sse_kms_key_type                      = "AWS_OWNED_CMK"
      create_role                           = true
      tags                                  = {}
      buffering_size                        = 1
      buffering_interval                    = 60
      enable_lambda_transform               = false
      transform_lambda_arn                  = null
      s3_bucket_arn                         = "arn:aws:s3:::aedata36"
      s3_prefix                             = "logs1/"
      s3_error_output_prefix                = null
      enable_s3_encryption                  = false
      s3_kms_key_arn                        = null
      s3_compression_format                 = "GZIP"
      enable_dynamic_partitioning           = false
      dynamic_partitioning_retry_duration   = 300
      vpc_subnet_ids                        = []
      enable_vpc                            = false
      vpc_security_group_destination_vpc_id = ""
      vpc_security_group_tags               = {}
      role_name                             = null
      policy_name                           = null
      role_description                      = null
      role_path                             = null
      role_force_detach_policies            = true
      role_permissions_boundary             = null
      role_tags                             = {}
      policy_path                           = null
      cw_log_retention_in_days              = 7
      cw_tags                               = {}
    },
    kinesis_firehose_2 = {
      deploy                                = true
      edp_environment                       = "dev"
      resource_name                         = "test"
      create                                = true
      name                                  = "example-firehose2"
      input_source                          = "direct-put"
      kinesis_source_stream_arn             = ""
      kinesis_source_use_existing_role      = false
      firehose_role                         = null
      enable_sse                            = false
      sse_kms_key_arn                       = null
      sse_kms_key_type                      = "AWS_OWNED_CMK"
      create_role                           = true
      tags                                  = {}
      buffering_size                        = 1
      buffering_interval                    = 60
      enable_lambda_transform               = false
      transform_lambda_arn                  = null
      s3_bucket_arn                         = "arn:aws:s3:::arike123"
      s3_prefix                             = "logs1/"
      s3_error_output_prefix                = null
      enable_s3_encryption                  = false
      s3_kms_key_arn                        = null
      s3_compression_format                 = "GZIP"
      enable_dynamic_partitioning           = false
      dynamic_partitioning_retry_duration   = 300
      vpc_subnet_ids                        = []
      enable_vpc                            = false
      vpc_security_group_destination_vpc_id = ""
      vpc_security_group_tags               = {}
      role_name                             = null
      policy_name                           = null
      role_description                      = null
      role_path                             = null
      role_force_detach_policies            = true
      role_permissions_boundary             = null
      role_tags                             = {}
      policy_path                           = null
      cw_log_retention_in_days              = 7
      cw_tags                               = {}
    }
  }
}