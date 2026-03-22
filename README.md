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
 
## Example root module usage
 
provider "aws" {
  region = var.aws_region
}

module "bedrock_fastapi_service" {
  source = "./modules/bedrock_fastapi_service"

  name               = "rag-api"
  aws_region         = var.aws_region
  vpc_id             = var.vpc_id
  public_subnet_ids  = var.public_subnet_ids
  private_subnet_ids = var.private_subnet_ids

  container_image = var.container_image
  model_arn       = var.model_arn
  knowledge_base_id = var.knowledge_base_id

  # optional
  knowledge_base_data_source_id = var.knowledge_base_data_source_id

  cpu           = 512
  memory        = 1024
  desired_count = 2

  container_port   = 8000
  health_check_path = "/health"

  app_environment = {
    APP_ENV = "prod"
    LOG_LEVEL = "INFO"
  }

  tags = {
    Project     = "rag-platform"
    Environment = "prod"
  }
}
