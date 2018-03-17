#####################################
# Security Group Settings
#####################################
resource "aws_security_group" "ec2_sg1" {
  name   = "${var.app_name} EC2_SG1"
  vpc_id = "${aws_vpc.vpc_main.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ssh_allow_ip}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  description = "${var.app_name} EC2_SG1"
}
