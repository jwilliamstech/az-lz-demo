# azure login related
az login

az account list --output table

az account set -s "xX-Enter Subscription Here-Xx"

az account show --output table

# terraform related
terraform init
# terraform init -reconfigure

terraform validate
terraform fmt
terraform plan -out=dev-plan -var-file="./environments/dev-variables.tfvars"
terraform apply dev-plan

terraform state list

# workspaces related
terraform workspace list

terraform workspace new dev

terraform workspace select dev


# deployment commands
terraform plan -out=dev-plan -var-file="./environments/dev-variables.tfvars"
terraform plan -out=test-plan -var-file="./environments/test-variables.tfvars"
terraform plan -out=prod-plan -var-file="./environments/prod-variables.tfvars"