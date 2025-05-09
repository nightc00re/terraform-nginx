resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.project}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.project}-igw"
  }
}

resource "aws_internet_gateway_attachment" "igw_attachment" {
  vpc_id              = aws_vpc.main.id
  internet_gateway_id = aws_internet_gateway.igw.id
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${var.aws_region}a"
  tags = {
    Name = "${var.project}-public-subnet"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  depends_on = [aws_internet_gateway_attachment.igw_attachment]
  tags = {
    Name = "${var.project}-public-rt"
  }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "nginx_sg" {
  vpc_id      = aws_vpc.main.id
  description = "Allow inbound traffic to Nginx and SSH"
  name_prefix = "${var.project}-sg-"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project}-nginx-sg"
  }
}

resource "aws_instance" "nginx_instance" {
  ami           = "ami-00fbe66e10e2eb0f5"  #  Use the explicit AMI ID
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.nginx_sg.id]
  user_data     = file("userdata.sh")
  associate_public_ip_address = true
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    Name = "${var.project}-nginx-ec2"
  }
}
