resource "aws_instance" "my_ec2_lab" {
    
    ami = var.ami
    instance_type = "t2.micro"
    subnet_id = aws_subnet.main.id
    vpc_security_group_ids = [aws_security_group.main.id]
    key_name = aws_key_pair.main.key_name
    associate_public_ip_address = true

    tags = {
      Name = "lab-EC2-Instance"
    }

    connection {
	   type = "ssh"
	   user = "ubuntu"
	   private_key = file("~/.ssh/id_ed25519")
	   host = self.public_ip
	}
    
    provisioner "remote-exec" {
        inline = [
            "mkdir -p /home/ubuntu/templates"
        ]
    }

    provisioner "file" {
    source      = "../Flask Application/app.py"  
    destination = "/home/ubuntu/app.py"  
   }

   provisioner "file" {
      source      = "../Flask Application/templates/index.html"
      destination = "/home/ubuntu/templates/index.html"
    }
	
	provisioner "remote-exec" {
	   inline = [
	        "sudo apt update -y",  
          "sudo apt-get install -y python3-pip python3-venv",  
          "cd /home/ubuntu",
          "python3 -m venv venv", # Create the virtual environment
          
          # 1. Install Flask and Gunicorn
          "/home/ubuntu/venv/bin/pip install flask gunicorn",
          
          # 2. Start Gunicorn and redirect logs
          # This command starts Gunicorn, runs it in the background (&), and uses nohup 
          # to ensure it detaches when the SSH session closes.
          "sudo sh -c '/home/ubuntu/venv/bin/gunicorn --bind 0.0.0.0:80 app:app > /home/ubuntu/flask_app.log 2>&1 &'",
	   ]
	   }

}

resource "aws_key_pair" "main" {
  key_name   = "homelab-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}
