data "aws_ssm_parameter" "ingress_alb" {
  name  = "/${var.project_name}-${var.environment}/ingress_alb"
}

    data "aws_ssm_parameter" "mysql" {
  name  = "/${var.project_name}-${var.environment}/mysql"
}
data "aws_ssm_parameter" "bastion" {
  name  = "/${var.project_name}-${var.environment}/bastion"
}

data "aws_ssm_parameter" "redis" {
  name  = "/${var.project_name}-${var.environment}/redis"
}
data "aws_ssm_parameter" "mongodb" {
  name  = "/${var.project_name}-${var.environment}/mongodb"
}

 data "aws_ssm_parameter" "eks_control_plane" {
  name  = "/${var.project_name}-${var.environment}/eks_control_plane"
}
data "aws_ssm_parameter" "eks_node" {
  name  = "/${var.project_name}-${var.environment}/eks_node"
}
data "aws_ssm_parameter" "openvpn" {
  name  = "/${var.project_name}-${var.environment}/openvpn"
}
data "aws_ssm_parameter" "rabbitmq" {
  name  = "/${var.project_name}-${var.environment}/rabbitmq"
}