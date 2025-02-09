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