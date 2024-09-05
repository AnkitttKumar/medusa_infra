resource "aws_db_instance" "medusa_db" {
  identifier        = "medusadb"
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  name              = "medusa"
  username          = var.db_username
  password          = var.db_password
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.medusa_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.medusa_subnet_group.name
}

resource "aws_db_subnet_group" "medusa_subnet_group" {
  name       = "medusa-subnet-group"
  subnet_ids = aws_subnet.medusa_subnet.*.id
}

