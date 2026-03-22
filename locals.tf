locals {
  name_prefix = var.name

  common_tags = merge(
    {
      Module = "bedrock_fastapi_service"
    },
    var.tags
  )

  container_environment = concat(
    [
      {
        name  = "AWS_REGION"
        value = var.aws_region
      },
      {
        name  = "MODEL_ARN"
        value = var.model_arn
      },
      {
        name  = "KNOWLEDGE_BASE_ID"
        value = var.knowledge_base_id
      }
    ],
    var.knowledge_base_data_source_id != null ? [
      {
        name  = "KNOWLEDGE_BASE_DATA_SOURCE_ID"
        value = var.knowledge_base_data_source_id
      }
    ] : [],
    [
      for k, v in var.app_environment : {
        name  = k
        value = v
      }
    ]
  )
}
