#####################################
# EC2 Settings
#####################################
resource "aws_instance" "public1" {
  ami           = "${var.ami1}"
  instance_type = "${var.instance_type1}"
  key_name = "${var.key_name}"
  subnet_id = "${aws_subnet.vpc_main-public-subnet1.id}"
  vpc_security_group_ids  = ["${aws_security_group.ec2_sg1.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ec2-profile.name}"

  tags {
    Name = "${var.app_name} public1"
  }
}