 
  

data "aws_ssm_parameter" "public_subnet" {
  name = "/${var.project_name}-${var.environment}/public_subnet_ids"
}
data "aws_ssm_parameter" "bastion" {
  name = "/${var.project_name}-${var.environment}/bastion"
  
}

output "public_id" {
  
 value = aws_instance.bastion.public_ip
}