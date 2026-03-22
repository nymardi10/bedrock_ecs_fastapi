# bedrock_fastapi_service

Reusable Terraform module for:
- ECS Fargate
- ALB
- FastAPI container
- Bedrock model invocation
- Bedrock Knowledge Base RAG access
- CloudWatch logs and alarms

## Inputs expected from root module

- `model_arn`
- `container_image`
- `knowledge_base_id`
- optional `knowledge_base_data_source_id`

## App expectations

The FastAPI container should:
- listen on the configured `container_port`
- expose a health endpoint on `health_check_path`
- use env vars:
  - `AWS_REGION`
  - `MODEL_ARN`
  - `KNOWLEDGE_BASE_ID`
  - optional `KNOWLEDGE_BASE_DATA_SOURCE_ID`

## Notes

- `container_image` must be an image URI, not an ECR ARN.
- The module grants the ECS task permission to:
  - invoke the specified Bedrock model
  - call retrieve / retrieve-and-generate on the specified Knowledge Base
