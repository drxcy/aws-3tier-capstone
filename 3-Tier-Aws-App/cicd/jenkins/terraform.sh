#!/bin/bash
set -e  # exit immediately if a command fails

# Path to Terraform project (adjust if different)
TERRAFORM_DIR="terraform"

echo "[INFO] Starting Terraform pipeline..."

# Navigate to Terraform folder
cd $TERRAFORM_DIR

# Initialize Terraform
terraform init -input=false

# Validate configuration
terraform validate

# Generate and save execution plan
terraform plan -out=tfplan -input=false

# Apply the plan automatically
terraform apply -input=false -auto-approve tfplan

echo "[INFO] Terraform apply completed successfully!"
