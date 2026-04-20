# az-lz-demo
Repository for terraform based Azure landing zone deployment modules. - Authored by Joshua Williams

This is a collection of terraform modules intended to demonstrate the realistic automation efforts involved in architecting and deploying flexible, preconfigured Azure platform landing zones. 

Environmental tfvars files are not replicated to Github repository as they contain sensitive values used for deployment with service principal registration. In a real-world scenario, these credentials would be hosted in Azure DevOps as env variables or in variable groups.
Environmental tfvars files should contain the following values for authentication...

sp-subscription-id = "xxxxxxxxxxxxxxxxxxxx"
sp-client-id       = "xxxxxxxxxxxxxxxxxxxx"
sp-client-secret   = "xxxxxxxxxxxxxxxxxxxx"
sp-tenant-id       = "xxxxxxxxxxxxxxxxxxxx"

Terraform workspace should be set in order to define workspace variable used in child module locals references such as...

"locals {
  default_tags = merge(var.default_tags, { "Environment" = "${terraform.workspace}" })
  environment  = terraform.workspace != "default" ? terraform.workspace : ""
}"

Set terraform workspace with the following command...

"terraform workspace new (env name here)"

and

"terraform workspace select (env name here)"

Leverage -out=env-plan -var-file="" flag to specify which set of environmental variables to use as seen in the following commands...

terraform plan -out=dev-plan -var-file="./environments/dev-variables.tfvars"
terraform apply dev-plan

Naming of resources is done leveraging concatenation of resource variables, environment variables, and suffix variables to ensure continuity of naming convention within each resources child module.
Encryption key creation and reference blocks have been commented out as Azure Containter Registry requires Premium sku for encryption.
