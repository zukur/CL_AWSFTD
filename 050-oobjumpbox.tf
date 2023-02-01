###########################################
#### Search for Amazon Linux image
###########################################
data "aws_ami" "amzn2-linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20221103.3-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["137112412989"]
}

###########################################
#### Deploy OOB Jumpbox
###########################################
resource "aws_instance" "oobjumpbox" {
  ami           = data.aws_ami.amzn2-linux.id
  instance_type = "t3.micro"
  key_name = aws_key_pair.deployer.key_name
  user_data = file("srv-oobjh_init.sh")

  network_interface {
    network_interface_id = aws_network_interface.oobjumpbox-nic.id
    device_index = 0
  }

  tags = {
    Name = "CL-FTD-OOBJumpbox"
  }
}
