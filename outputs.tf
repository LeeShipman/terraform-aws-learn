
output "ec2_public_ip" {
  value = module.my-app-webserver.instance.public_ip
}



