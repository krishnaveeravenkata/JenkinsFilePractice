resource "aws_instance" "name" {

  ami = "ami-0a914de4dc1f18727"
  instance_type = "t2.micro"

  tags = {
    Name = "krishna_python_server"
  }
  subnet_id = "subnet-0c048f691074d169c"
}