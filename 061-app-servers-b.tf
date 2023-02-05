###########################################
#### Create network interface
###########################################

#resource "aws_network_interface" "srv-b-nic" {
#  subnet_id         = aws_subnet.subnet_inside-a.id
#  source_dest_check = false
#  private_ips = ["10.42.2.101"]
#  tags = {
#      Name = "CL-FTD-srv-b-nic"
#  }
#}

#resource "aws_network_interface_sg_attachment" "srv-b-nic_attachment" {
#  security_group_id    = aws_security_group.srv-mgmt.id
#  network_interface_id = aws_network_interface.srv-b-nic.id
#}

###########################################
#### Deploy linux server
###########################################
#resource "aws_instance" "srv-b" {
#  ami           = data.aws_ami.ubuntu.id
#  instance_type = "t3.small"
#  key_name = aws_key_pair.deployer.key_name
#  user_data = file("srv-a_init.sh")

#  network_interface {
#    network_interface_id = aws_network_interface.srv-b-nic.id
#    device_index = 0
#  }

#  depends_on = [
#    aws_internet_gateway.igw-outside,
#    aws_route_table_association.assoc-outside-a,
#    aws_nat_gateway.natgw-a
#  ]

#  tags = {
#    Name = "CL-FTD-srv-b"
#  }
#}
