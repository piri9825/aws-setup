resource "aws_ecr_repository" "ecr_repo" {
  name = "${var.project_name}-${var.ecr_repo}"
}

resource "null_resource" "build_push_image" {

  provisioner "local-exec" {
    command = <<EOT
      docker build -t ${aws_ecr_repository.ecr_repo.id} ..
      docker tag ${aws_ecr_repository.ecr_repo.id}:latest ${aws_ecr_repository.ecr_repo.repository_url}:latest
      docker push ${aws_ecr_repository.ecr_repo.repository_url}:latest
    EOT
  }
}

resource "aws_ecr_repository" "ecr_repo_dash" {
  name = "${var.project_name}-${var.ecr_repo}-dash"
}

resource "null_resource" "build_push_image_dash" {

  provisioner "local-exec" {
    command = <<EOT
      docker build -f Dockerfile.dash -t ${aws_ecr_repository.ecr_repo_dash.id} ..
      docker tag ${aws_ecr_repository.ecr_repo_dash.id}:latest ${aws_ecr_repository.ecr_repo_dash.repository_url}:latest
      docker push ${aws_ecr_repository.ecr_repo_dash.repository_url}:latest
    EOT
  }
}