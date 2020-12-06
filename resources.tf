#create Security Group
resource "aws_security_group" "Media-SG" {
  name        = "Media-SG"
  description = "Allow http,https,ssh traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Media-SG"
  }
}

resource "aws_instance" "Server" {
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${var.subnetID}"
  security_groups             = ["${aws_security_group.Media-SG.id}"]
  associate_public_ip_address = true
  key_name                    = "${var.instance_key}"
  tags = {
    Name = "Mediawiki-Server"
  }

  provisioner "chef" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = "${aws_instance.Server.public_ip}"
      private_key = "${file("mwkey.pem")}"
    }
    os_type                 = "linux"
    prevent_sudo            = false
    client_options          = ["chef_license 'accept'"]
    log_to_file             = true
    fetch_chef_certificates = true
    node_name               = "Mediawiki-Server"
    server_url              = "https://api.chef.io/organizations/twproject"
    recreate_client         = true
    run_list                = ["recipe[mediawiki]"]
    user_name               = "shradz16"
    user_key                = "${file("shradz16.pem")}"
    ssl_verify_mode         = ":verify_none"
  }
}
