data "aws_ssm_parameter" "vpc_id" {
    name = "/${local.common_name}/vpc_id"

}


 data "aws_ssm_parameter" "eks_control_plane_sg_id" {
  name  = "/${var.project_name}-${var.environment}/eks_control_plane"
}

data "aws_ssm_parameter" "eks_node_sg_id" {
  name  = "/${var.project_name}-${var.environment}/eks_node"
}

data "aws_ssm_parameter" "private_subnet_ids" {
    name = "/${var.project_name}-${var.environment}/private_subnet_ids"
}