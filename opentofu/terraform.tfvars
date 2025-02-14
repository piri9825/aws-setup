project_name = "aws-setup"
state_bucket = "tofu-backend"
state_key    = ".tfstate"

region  = "eu-north-1"
profile = "admin-1"

datastore              = "datastore"
ecr_repo               = "ecr-repo"
pull_ice_cot_lambda    = "pull_ice_cot"
iam_lambda             = "iam_for_lambda"
ice_cot_sns_push       = "ice_cot_sns_push"
ice_cot_sqs            = "ice_cot_sqs"
process_ice_cot_lambda = "process_ice_cot"
aws-setup-dynamodb     = "aws-setup-dynamodb"