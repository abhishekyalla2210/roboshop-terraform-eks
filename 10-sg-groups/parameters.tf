resource "aws_ssm_parameter" "main" {       
   count = length(var.sg_names)
   name  = "/${var.project_name}-${var.environment}/${var.sg_names[count.index]}"
    type  = "String"    
    value = aws_security_group.main[count.index].id
    overwrite = true
}