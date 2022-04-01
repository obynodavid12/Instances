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

  user_data   = <<-EOF
                #!/bin/bash
                apt update -y
                wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
                chmod +x ./jq
                sudo cp jq /usr/bin
                curl --request POST 'https://api.github.com/repos/obynodavid12/Instances/actions/runners/registration-token' --header "Authorization: token ${personal_access_token}" > output.txt
                runner_token=\$(jq -r '.token' output.txt)
                mkdir /home/ubuntu/actions-runner && cd /home/ubuntu/actions-runner || exit
                curl -o actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
                tar xzf ./actions-runner-linux-x64-2.289.2.tar.gz
                chown -R ubuntu /home/ubuntu/actions-runner
                rm /home/ubuntu/actions-runner/actions-runner-linux-x64-2.289.2.tar.gz
                REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
                INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
                sudo -i u ubuntu bash << EOF
                /home/ubuntu/actions-runner/config.sh --url https://github.com/obynodavid12/Instances/ --token \$runner_token --name "DEV-TEST-SELFHOSTED-RUNNER" --unattended
                EOF
                echo "Configured"
                sudo ./svc.sh install
                echo "Installed"
                sudo ./svc.sh start
                echo "Started"
 
  tags = {
    Name = "${var.namespace}-SELFHOSTED-RUNNER"
  }
}


