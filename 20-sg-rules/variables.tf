variable "sg_names" {
    type = list
    default = [
        "mongodb", "redis", "mysql", "rabbitmq",
        
        "frontend", "ingress_alb",
        "bastion",
        
        "openvpn",
        "eks_control_plane",
        "eks_node"
    ]
}

variable "project_name" {
    type = string
    default = "roboshop"
  
}

variable "environment" {
    type = string
    default = "dev"
  
}