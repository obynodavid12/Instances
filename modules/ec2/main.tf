// Create aws_ami filter to pick up the ami available in your region
  
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}



// Configure the EC2 instance in a public subnet
resource "aws_instance" "bastion_host" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = var.vpc.public_subnets[0]
  vpc_security_group_ids      = [var.sg_pub_id]

  tags = {
    Name = "${var.namespace}-BASTION-HOST"
  }

  # Copies the ssh key file to home dir
  provisioner "file" {
    source      = "./${var.key_name}.pem"
    destination = "/home/ubuntu/${var.key_name}.pem"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }
  }
  
  //chmod key 400 on EC2 instance
  provisioner "remote-exec" {
    inline = ["chmod 400 ~/${var.key_name}.pem"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }

  }

}


// Configure the EC2 instance in a private subnet
resource "aws_instance" "selfhosted_runner" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = false
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = var.vpc.private_subnets[1]
  vpc_security_group_ids      = [var.sg_priv_id]
<<<<<<< HEAD
              
  user_data = templatefile("scripts/createsvc.sh", {RUNNER_CFG_PAT = var.RUNNER_CFG_PAT})
=======
  
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              export RUNNER_CFG_PAT=$(RUNNER_CFG_PAT)
              curl -s https://raw.githubusercontent.com/actions/runner/main/scripts/create-latest-svc.sh | bash -s obynodavid12/Instances
              EOF
>>>>>>> 0d562c61f52038e7016bce3d5e35f1ace978357d
  tags = {
    Name = "${var.namespace}-SELFHOSTED-RUNNER"
  }
}



