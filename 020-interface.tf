###########################################
#### Create Network Interfaces
#### Assign Security Group to Interface
###########################################
resource "aws_network_interface" "fmc-mgmt" {
  description       = "CL-FTD-fmc-mgmt"
  subnet_id         = aws_subnet.subnet_management-a.id
  source_dest_check = false
  private_ips = ["10.42.3.100"]
  tags = {
      Name = "CL-FTD-FMC-MGMT"
  }
}

resource "aws_network_interface_sg_attachment" "fmc_mgmt_attachment" {
  security_group_id    = aws_security_group.ftd-mgmt.id
  network_interface_id = aws_network_interface.fmc-mgmt.id
}

resource "aws_network_interface" "srv-a-nic" {
  subnet_id         = aws_subnet.subnet_inside-a.id
  source_dest_check = false
  private_ips = ["10.42.2.100"]
  tags = {
      Name = "CL-FTD-srv-a-nic"
  }
}

resource "aws_network_interface_sg_attachment" "srv-a-nic_attachment" {
  security_group_id    = aws_security_group.srv-mgmt.id
  network_interface_id = aws_network_interface.srv-a-nic.id
}

resource "aws_network_interface" "oobjumpbox-nic" {
  subnet_id         = aws_subnet.subnet_management-a.id
  source_dest_check = false
  private_ips = ["10.42.3.101"]
  tags = {
      Name = "CL-FTD-oobjumpbox-nic"
  }
}

resource "aws_network_interface_sg_attachment" "oobjumpboox_mgmt_attachment" {
  security_group_id    = aws_security_group.srv-mgmt.id
  network_interface_id = aws_network_interface.oobjumpbox-nic.id
}

resource "aws_network_interface" "ftdv01-outside" {
  subnet_id         = aws_subnet.subnet_outside-a.id
  source_dest_check = false
  private_ips = ["10.42.1.10"]
  tags = {
      Name = "CL-FTD-ftdv01-outside"
  }
}

resource "aws_network_interface_sg_attachment" "ftdv01-out_attachment" {
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.ftdv01-outside.id
}

resource "aws_network_interface" "ftdv01-inside" {
  subnet_id         = aws_subnet.subnet_inside-a.id
  source_dest_check = false
  private_ips = ["10.42.2.10"]
  tags = {
      Name = "CL-FTD-ftdv01-inside"
  }
}

resource "aws_network_interface_sg_attachment" "ftdv01-in_attachment" {
  security_group_id    = aws_security_group.allow_all.id
  network_interface_id = aws_network_interface.ftdv01-inside.id
}

resource "aws_network_interface" "ftdv01-management" {
  subnet_id         = aws_subnet.subnet_management-a.id
  source_dest_check = false
  private_ips = ["10.42.3.10"]
  tags = {
      Name = "CL-FTD-ftdv01-mgmt"
  }
}

resource "aws_network_interface_sg_attachment" "ftdv01-mgmt_attachment" {
  security_group_id    = aws_security_group.ftd-mgmt.id
  network_interface_id = aws_network_interface.ftdv01-management.id
}

resource "aws_network_interface" "ftdv01-diag" {
  subnet_id         = aws_subnet.subnet_diag-a.id
  source_dest_check = false
  private_ips = ["10.42.255.10"]
  tags = {
      Name = "CL-FTD-ftdv01-diag"
  }
}

resource "aws_network_interface_sg_attachment" "ftdv01-diag_attachment" {
  security_group_id    = aws_security_group.ftd-mgmt.id
  network_interface_id = aws_network_interface.ftdv01-diag.id
}

###########################################
#### Create Elastic IP (Public IP) for Interfaces
###########################################
resource "aws_eip" "oobjumpbox-eip" {
  vpc                       = true
  network_interface         = aws_network_interface.oobjumpbox-nic.id
  associate_with_private_ip = "10.42.3.101"
  tags = {
      Name = "CL-FTD-oobjumpbox-eip"
  }
}

resource "aws_eip" "ftdv01-eip" {
  vpc                       = true
  network_interface         = aws_network_interface.ftdv01-outside.id
  associate_with_private_ip = "10.42.1.10"
  tags = {
      Name = "CL-FTD-ftdv01-eip"
  }
}

resource "aws_eip" "fmc-eip" {
  vpc                       = true
  network_interface         = aws_network_interface.fmc-mgmt.id
  associate_with_private_ip = "10.42.3.100"
  tags = {
      Name = "CL-FTD-fmc-eip"
  }
}