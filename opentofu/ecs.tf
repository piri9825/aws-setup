resource "aws_ecs_cluster" "ice_cot_cluster" {
  name = "ice-cot-cluster"
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "ecs_instance" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = "t3.medium"
  key_name                    = "ssh-key"
  vpc_security_group_ids      = [aws_security_group.ecs_sg.id]
  subnet_id                   = aws_subnet.public_1.id
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  associate_public_ip_address = true

  user_data = <<-EOF
#!/bin/bash
set -ex

# Enable ECS agent installation
amazon-linux-extras enable ecs
yum install -y ecs-init

# Configure ECS to use the cluster
echo "ECS_CLUSTER=${aws_ecs_cluster.ice_cot_cluster.name}" > /etc/ecs/ecs.config
echo "ECS_LOGLEVEL=debug" >> /etc/ecs/ecs.config
echo 'ECS_AVAILABLE_LOGGING_DRIVERS=["json-file","awslogs"]' >> /etc/ecs/ecs.config

# Install Docker
amazon-linux-extras enable docker
yum install -y docker
systemctl enable --now docker

# Add ec2-user to Docker group for permission fixes
usermod -aG docker ec2-user

# Restart ECS agent to apply config
systemctl enable --now --no-block ecs.service
EOF
}

resource "aws_ecs_task_definition" "ice_cot_task" {
  family                   = "ice-cot-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = "512"
  memory                   = "512"

  container_definitions = jsonencode([{
    name      = "ice-cot-dash"
    image     = "${aws_ecr_repository.ecr_repo_dash.repository_url}:latest"
    cpu       = 512
    memory    = 512
    essential = true
    portMappings = [
      {
        containerPort = 8050
        hostPort      = 8050
      }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
        "awslogs-region"        = var.region
        "awslogs-stream-prefix" = "ice-cot-dash"
      }
    }
  }])
}

resource "aws_ecs_service" "ice_cot_service" {
  name            = "ice-cot-service"
  cluster         = aws_ecs_cluster.ice_cot_cluster.id
  task_definition = aws_ecs_task_definition.ice_cot_task.arn
  desired_count   = 1
  launch_type     = "EC2"
}
