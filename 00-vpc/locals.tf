locals {
  common_name = "${var.project_name}-${var.environment}"
  az_zones = slice(data.aws_availability_zones.availability_zone.names, 0, 2)
}