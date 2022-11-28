terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# data "template_file" "user_data" {
# template = "${file("demo.ps1")}"
# }


resource "aws_launch_template" "foobar11" {
  name_prefix   = "foobar"
  image_id      = "ami-0c95d38b24a19de18"
  instance_type = "t2.micro"
  key_name = "mykeypair"

#   user_data = "${base64encode(file("demo.ps1"))}"
#   user_data = "${base64encode(data.template_file.user_data.rendered)}"
    user_data = "${base64encode(file("user_data.txt"))}"
}

resource "aws_autoscaling_group" "bar" {
  name                      = "foobar3-terraform-test"
  availability_zones = ["us-east-1a"]
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  launch_template {
    id      = aws_launch_template.foobar11.id
    version = "$Latest"
  }
  

}