##############################################
# RDS MySQL Instance
# - Automated Snapshots (2 days retention)
# - Deletion Protection Enabled
##############################################

resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-rds-subnet-group"
  subnet_ids = var.private_subnets

  tags = {
    Name        = "${var.project_name}-rds-subnet-group"
    Environment = var.environment
  }
}

resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow MySQL from web tier"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.web_sg_id]
    description     = "MySQL from web servers"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-rds-sg"
    Environment = var.environment
  }
}

resource "aws_db_instance" "mysql" {
  identifier     = "${var.project_name}-rds"
  engine         = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "myappdb"
  username = "admin"
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  # Automated Snapshots - 2 days retention
  backup_retention_period = 2
  backup_window           = "03:00-04:00"

  # Termination Protection
  deletion_protection = true

  multi_az            = false
  publicly_accessible = false
  skip_final_snapshot = true

  tags = {
    Name        = "${var.project_name}-rds"
    Environment = var.environment
  }
}
