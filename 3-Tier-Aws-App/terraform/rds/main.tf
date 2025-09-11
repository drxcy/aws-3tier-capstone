# Security Group for RDS
resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Allow only backend EC2"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [data.terraform_remote_state.ec2.outputs.web_sg_id] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-db-sg"
  }
}

# DB Subnet Group
resource "aws_db_subnet_group" "db_subnets" {
  name       = "rds-private-subnet-group"
  subnet_ids = [data.terraform_remote_state.vpc.outputs.Private_subnet_id_a,
  data.terraform_remote_state.vpc.outputs.Private_subnet_id_b
  ]

  tags = {
    Name = "RDS Private Subnet Group"
  }
}

# RDS Instance
resource "aws_db_instance" "postgres" {
  identifier              = "my-postgres-db"
  engine                  = "postgres"
  engine_version          = "17"
  instance_class          = var.DB_INSTANCE
  db_name                 = var.DB_NAME
  username                = var.DB_USERNAME
  password                = var.DB_PASSWORD
  allocated_storage       = var.DB_STORAGE
  max_allocated_storage   = var.DB_STORAGE
  storage_type            = "gp2"
  db_subnet_group_name    = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids  = [aws_security_group.db_sg.id]
  publicly_accessible     = false
  skip_final_snapshot     = true
  multi_az                = false

  tags = {
    Name = "RDS-Postgres17"
  }
}
