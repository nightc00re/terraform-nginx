data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Amazon Linux 2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "nginx_instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type # Use the variable
  key_name      = var.key_name      # Use the variable
  vpc_security_group_ids = [aws_security_group.nginx_sg.id] #<--ADDED
  tags = {
    Name = "${var.project}-nginx-ec2" #Use variable
  }
  user_data     = file("userdata.sh")
  subnet_id = aws_subnet.public_subnet.id #Added
}
