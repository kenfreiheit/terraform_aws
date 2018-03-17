#####################################
# IAM Role Settings
#####################################
# IAM Role for EC2
data "aws_iam_policy_document" "ec2-role" {

  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# IAM Role Policy for EC2
data "aws_iam_policy_document" "ec2-role_policy" {
  statement {
    effect = "Allow"
    actions = [
        "autoscaling:Describe*",
        "cloudwatch:*",
        "logs:*",
        "sns:*",
    ]

    resources = [
      "*",
    ]
  }
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "ec2-profile" {
  name  = "${var.app_name}-ec2-profile"
  role = "${aws_iam_role.ec2-role.name}"
}

# Role
resource "aws_iam_role" "ec2-role" {
  name               = "${var.app_name}-ec2-role"
  assume_role_policy = "${data.aws_iam_policy_document.ec2-role.json}"
}

# Role-Policy
resource "aws_iam_role_policy" "ec2-role_policy" {
  name   = "${var.app_name}-ec2-role-policy"
  role   = "${aws_iam_role.ec2-role.id}"
  policy = "${data.aws_iam_policy_document.ec2-role_policy.json}"
}