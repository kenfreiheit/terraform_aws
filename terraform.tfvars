#####################################
# TerraForm Variable Settings
#####################################
#AWS Settings
region = "ap-northeast-1"

#App Name
app_name = "sample"

#Segment Settings
root_segment = "10.20.0.0/16"
public_segment1 = "10.20.10.0/24"

#AZ Settings
public_segment1_az = "ap-northeast-1a"

#SG Settings
ssh_allow_ip = "0.0.0.0/0"

#EC2 Settings
ami1 = "ami-617c3007"
instance_type1 = "t1.micro" 