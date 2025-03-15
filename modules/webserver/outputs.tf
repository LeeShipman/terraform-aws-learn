output "sg-id" {
    value = aws_security_group.myapp-sg.id
}

output "instance" {
    value = aws_instance.myapp-webserver
}