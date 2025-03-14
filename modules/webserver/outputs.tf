output "sg-id" {
    value = aws_default_security_group.default-sg
}

output "instance" {
    value = aws_instance.myapp-webserver
}