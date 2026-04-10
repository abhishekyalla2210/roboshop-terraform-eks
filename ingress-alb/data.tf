data "aws_ssm_parameter" "lb_sg" {
  name = "/${var.project_name}-${var.environment}/ingress_alb"
}
data "aws_ssm_parameter" "public_subnet_ids" {
  name = "/${var.project_name}-${var.environment}/public_subnet_ids"
  
}

data "aws_ssm_parameter" "arn" {
    name = "/${var.project_name}/${var.environment}/ingress_alb_certificate_arn"

}
data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}-${var.environment}/vpc_id"
}