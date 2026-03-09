resource "random_string" "mystring" {
  length = 10
  special = false
  upper = false
}



resource "aws_instance" "myec2" {
  ami           = var.myami
  instance_type = var.myinstance
  region        = var.myregion

  tags = {
    Name = "tom-${random_string.mystring.result}"
  }
}