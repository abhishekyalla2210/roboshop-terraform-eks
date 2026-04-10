resource "aws_lb" "ingress_alb" {
  name               = "roboshop-ingress-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [local.alb_sg]
  subnets            = local.subnet

  enable_deletion_protection = false

}

resource "aws_lb_listener" "ingress_alb" {
  load_balancer_arn = aws_lb.ingress_alb.arn # Reference to your ALB resource
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-3-2021-06"
  certificate_arn   = local.certificate_arn # Reference to your ACM certificate

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"

      message_body = "from frontend bro"
      status_code = 200
    }
  }
}

resource "aws_route53_record" "ingress_alb" {
  zone_id = var.zone_id# Reference your Route 53 hosted zone
  name    = "*.${var.domain_name}"                  # The subdomain you want to use
  type    = "A"
  allow_overwrite = true

  alias {
    name                   = aws_lb.ingress_alb.dns_name
    zone_id                = aws_lb.ingress_alb.zone_id
    evaluate_target_health = true # Optional: Evaluate ALB health for Route 53 health checks
  }
}



# resource "aws_lb_target_group" "ingress_alb" {
#   name     = "roboshop-ingress-tg"
#   port     = 8080
#   protocol = "HTTP"
#   target_type = "ip"
#   vpc_id   = local.vpc_id
#   deregistration_delay = 60 # waiting period before deleting the instance

#   health_check {
#     healthy_threshold = 2
#     interval = 10
#     matcher = "200-299"
#     path = "/"
#     port = 8080
#     protocol = "HTTP"
#     timeout = 2
#     unhealthy_threshold = 2
#   }
# }
# resource "aws_lb_listener_rule" "ingress" {
#   listener_arn = aws_lb_listener.ingress_alb.arn
#   priority     = 10

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.ingress_alb.arn
#   }

#   condition {
#     host_header {
#       values = ["roboshop-${var.environment}.${var.domain_name}"]
#     }
#   }
# }
