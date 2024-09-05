resource "aws_ecs_cluster" "medusa_cluster" {
  name = "medusa-cluster"
}

resource "aws_ecs_task_definition" "medusa_task" {
  family                   = "medusa-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name  = "medusa-container"
    image = var.medusa_image # Replace with your Medusa Docker image
    essential = true

    portMappings = [{
      containerPort = 9000
      hostPort      = 9000
    }]

    environment = [
      {
        name  = "DATABASE_URL"
        value = "postgres://${var.db_username}:${var.db_password}@${aws_db_instance.medusa_db.address}:5432/medusa"
      }
    ]
  }])
}

resource "aws_ecs_service" "medusa_service" {
  name            = "medusa-service"
  cluster         = aws_ecs_cluster.medusa_cluster.id
  task_definition = aws_ecs_task_definition.medusa_task.arn
  desired_count   = 1

  network_configuration {
    subnets         = aws_subnet.medusa_subnet.*.id
    security_groups = [aws_security_group.medusa_sg.id]
    assign_public_ip = true
  }

  launch_type = "FARGATE"
}
resource "aws_ecs_cluster" "medusa_cluster" {
  name = "medusa-cluster"
}

resource "aws_ecs_task_definition" "medusa_task" {
  family                   = "medusa-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name  = "medusa-container"
    image = var.medusa_image # we can add our MEDUSA Docke image
    essential = true

    portMappings = [{
      containerPort = 9000
      hostPort      = 9000
    }]

    environment = [
      {
        name  = "DATABASE_URL"
        value = "postgres://${var.db_username}:${var.db_password}@${aws_db_instance.medusa_db.address}:5432/medusa"
      }
    ]
  }])
}

resource "aws_ecs_service" "medusa_service" {
  name            = "medusa-service"
  cluster         = aws_ecs_cluster.medusa_cluster.id
  task_definition = aws_ecs_task_definition.medusa_task.arn
  desired_count   = 1

  network_configuration {
    subnets         = aws_subnet.medusa_subnet.*.id
    security_groups = [aws_security_group.medusa_sg.id]
    assign_public_ip = true
  }

  launch_type = "FARGATE"
}

