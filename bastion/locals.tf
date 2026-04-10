locals {
  bastion_sg_id = data.aws_ssm_parameter.bastion.value

  public_subnets = split(",", data.aws_ssm_parameter.public_subnet.value)
}
