
output "alb-url" {
  value = "http://${aws_alb.my-alb.dns_name}"
}