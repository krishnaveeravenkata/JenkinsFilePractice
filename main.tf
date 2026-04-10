resource "aws_instance" "name" {

  ami = "ami-0a914de4dc1f18727"
  instance_type = "t2.micro"

  tags = {
    Name = "krishna_python_server"
  }
  key_name = "kkp"
  subnet_id = "subnet-0c048f691074d169c"
  associate_public_ip_address = true
}