project_name = "aws-setup"
state_bucket = "tofu-backend"
state_key    = ".tfstate"

region  = "eu-north-1"
profile = "admin-1"

datastore      = "datastore"
ecr_repo       = "ecr-repo"
ice_cot_lambda = "pull_ice_cot"
iam_lambda     = "iam_for_lambda"