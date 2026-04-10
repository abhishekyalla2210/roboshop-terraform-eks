locals {
  alb_sg = data.aws_ssm_parameter.lb_sg.value
  subnet = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
    certificate_arn = data.aws_ssm_parameter.arn.value
    vpc_id = data.aws_ssm_parameter.vpc_id.value
}