#!/bin/bash

POLICY_NAME="TestPermissionBoundary"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Create a permissive test boundary (allows most actions for testing)
aws iam create-policy \
  --policy-name "$POLICY_NAME" \
  --policy-document '{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowEC2",
        "Effect": "Allow",
        "Action": [
          "ec2:*"
        ],
        "Resource": "*"
      },
      {
        "Sid": "AllowEKS",
        "Effect": "Allow",
        "Action": [
          "eks:*"
        ],
        "Resource": "*"
      },
      {
        "Sid": "AllowAutoscaling",
        "Effect": "Allow",
        "Action": [
          "autoscaling:*"
        ],
        "Resource": "*"
      },
      {
        "Sid": "AllowIAMReadAndPassRole",
        "Effect": "Allow",
        "Action": [
          "iam:GetRole",
          "iam:GetInstanceProfile",
          "iam:PassRole",
          "iam:SimulatePrincipalPolicy"
        ],
        "Resource": "*"
      }
    ]
  }' \
  --description "Test permission boundary for CAST AI roles"

echo ""
echo "Permission boundary ARN:"
echo "arn:aws:iam::${ACCOUNT_ID}:policy/${POLICY_NAME}"