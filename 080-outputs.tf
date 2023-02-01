###########################################
#### Print outputs to the terminal
###########################################

output "oobjumpbox_IP" {
  value = aws_instance.oobjumpbox.public_ip
}

output "ftdv01_IP" {
  value = aws_eip.ftdv01-eip.public_ip
}

output "fmc_IP" {
  value = aws_eip.fmc-eip.public_ip
}