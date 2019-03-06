provider "aws" {
    region = "us-east-2"
}

variable "server_port" {
    description = "The port the server will use for HTTP requests"
    default = 8080
}

variable "ami" {
    description = "AMI to be used for the server"
    default = "ami-064a578446f1dbf1e"
}

variable "key_pair" {
    description = "Key pair to ssh into box with"
    default = "example-spring"
}

resource "aws_security_group" "instance" {
    name = "terraform-example-instance"
    
    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = "${var.server_port}"
        to_port = "${var.server_port}"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "node1" {
    ami = "${var.ami}"
    instance_type = "t2.micro"

    vpc_security_group_ids = ["${aws_security_group.instance.id}"]    

    key_name = "${var.key_pair}"
    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p "${var.server_port}" &
                EOF

    tags {
        Name = "scout-node-1"
    }
}

resource "aws_instance" "node2" {
    ami = "${var.ami}"
    instance_type = "t2.micro"

    vpc_security_group_ids = ["${aws_security_group.instance.id}"]    

    key_name = "${var.key_pair}"
    user_data = <<-EOF
                #!/bin/bash
                echo "Hello, World" > index.html
                nohup busybox httpd -f -p "${var.server_port}" &
                EOF

    tags {
        Name = "scout-node-2"
    }
}

resource "aws_db_parameter_group" "scout-params" {
  name   = "scout-parameters"
  family = "mariadb10.3"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}


resource "aws_db_instance" "scout-db" {
    allocated_storage    = 10
    storage_type         = "standard"
    engine               = "mariadb"
    engine_version       = "10.3"
    instance_class       = "db.t3.micro"
    name                 = "scout"
    username             = "foo"
    password             = "foobarbaz"
    publicly_accessible  = true
    parameter_group_name = "${aws_db_parameter_group.scout-params.name}"
}


output "public_ip1" {
    value = "${aws_instance.node1.public_ip}"
}

output "public_ip2" {
    value = "${aws_instance.node2.public_ip}"
}

output "rds_hostname" {
    value = "${aws_db_instance.scout-db.endpoint}"
}
