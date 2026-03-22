variable "name" {
  description = "Base name used for all resources."
  type        = string
}

variable "aws_region" {
  description = "AWS region for the deployment."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where ALB and ECS service will run."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS Fargate tasks."
  type        = list(string)
}

variable "container_image" {
  description = "Container image URI for the FastAPI service."
  type        = string
}

variable "container_port" {
  description = "FastAPI container port."
  type        = number
  default     = 8000
}

variable "cpu" {
  description = "Fargate task CPU units."
  type        = number
  default     = 512
}

variable "memory" {
  description = "Fargate task memory in MiB."
  type        = number
  default     = 1024
}

variable "desired_count" {
  description = "Desired ECS service task count."
  type        = number
  default     = 1
}

variable "health_check_path" {
  description = "Health check path exposed by FastAPI."
  type        = string
  default     = "/health"
}

variable "assign_public_ip" {
  description = "Whether ECS tasks should get a public IP."
  type        = bool
  default     = false
}

variable "app_environment" {
  description = "Additional environment variables for the application."
  type        = map(string)
  default     = {}
}

variable "app_secrets" {
  description = "Secrets passed to the container from Secrets Manager or SSM Parameter Store."
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = []
}

variable "model_arn" {
  description = "Bedrock model ARN injected from the root module."
  type        = string
}

variable "knowledge_base_id" {
  description = "Bedrock Knowledge Base ID injected from the root module."
  type        = string
}

variable "knowledge_base_data_source_id" {
  description = "Optional Bedrock Knowledge Base data source ID."
  type        = string
  default     = null
}

variable "enable_execute_command" {
  description = "Enable ECS Exec for debugging."
  type        = bool
  default     = true
}

variable "log_retention_in_days" {
  description = "Retention for CloudWatch logs."
  type        = number
  default     = 30
}

variable "alarm_sns_topic_arn" {
  description = "Optional SNS topic ARN for CloudWatch alarms."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags applied to all resources."
  type        = map(string)
  default     = {}
}
