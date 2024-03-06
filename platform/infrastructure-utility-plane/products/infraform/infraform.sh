#!/bin/bash

kind=""
name=""
stage=""
cmd=""
gcp_cred_path=""

# FUNCTIONS
usage(){
    echo "Terraform commands wrapper" >&2
    echo "usage : $0 --cmd" >&2
    echo "--cmd      terraform command to play"
    exit 0
}


##################################################################
### MAIN
##################################################################
# Parse arguments
echo "$@"
while [ $# -gt 0 ]; do
  case $1 in
    --kind) kind=$2 ; shift 2 ;;
    --name) name=$2 ; shift 2 ;;
    --stage) stage=$2 ; shift 2 ;;
    --cmd) cmd=$2 ; shift 2 ;;
    -h|-help|--help) usage;;
    * ) break ;;
  esac
done


BASE_DIR="${kind}/${name}"
TERRAFORM_BASE_DIR="${BASE_DIR}/${stage}/terraform"

echo "Initialise terraform: "
echo "TF_IN_AUTOMATION=true TF_DATA_DIR=\".terraform\" terraform -chdir=\"${TERRAFORM_BASE_DIR}\" init --backend-config=\"$(pwd)/backend.tfvars\""
TF_IN_AUTOMATION=true TF_DATA_DIR=".terraform" terraform -chdir="${TERRAFORM_BASE_DIR}" init -backend-config="$(pwd)/backend.tfvars"

echo "$cmd terraform: "

if [ $cmd == "output" ]; then
  echo "TF_DATA_DIR=\".terraform\" terraform -chdir=\"${TERRAFORM_BASE_DIR}\" \"${cmd}\""
  TF_DATA_DIR=".terraform" terraform -chdir="${TERRAFORM_BASE_DIR}" "${cmd}"
else
  echo "TF_DATA_DIR=\".terraform\" terraform -chdir=\"${TERRAFORM_BASE_DIR}\" \"${cmd}\" -var-file \"$(pwd)/${TERRAFORM_BASE_DIR}/config.tfvars\"  -var-file \"$(pwd)/${BASE_DIR}/common.tfvars\" -var-file \"$(pwd)/common.tfvars\" -var-file \"$(pwd)/secrets.tfvars\""
  TF_DATA_DIR=".terraform" terraform -chdir="${TERRAFORM_BASE_DIR}" "${cmd}" -var-file "$(pwd)/${TERRAFORM_BASE_DIR}/config.tfvars" -var-file "$(pwd)/${BASE_DIR}/common.tfvars" -var-file "$(pwd)/common.tfvars" -var-file "$(pwd)/secrets.tfvars"
fi