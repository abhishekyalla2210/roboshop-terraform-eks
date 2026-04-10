resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${local.common_name}/vpc_id"
  type  = "String"
  value = aws_vpc.main.id
  overwrite = true
}

resource "aws_ssm_parameter" "public_subnet_ids" {
      
  name  = "/${local.common_name}/public_subnet_ids"
  type  = "StringList"
value = join(",", aws_subnet.public_subnet[*].id)
overwrite = true
}

resource "aws_ssm_parameter" "private_subnet_ids" {

  name  = "/${local.common_name}/private_subnet_ids"
  type  = "StringList"
value = join(",", aws_subnet.private_subnet[*].id)
overwrite = true
}
