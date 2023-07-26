#!/bin/bash

# Validate AWS CLI installation
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it and configure your credentials."
    exit 1
fi

# Validate kubectl installation
if ! command -v kubectl &> /dev/null; then
    echo "kubectl is not installed. Please install it."
    exit 1
fi

# Validate Helm installation
if ! command -v helm &> /dev/null; then
    echo "Helm is not installed. Please install it."
    exit 1
fi

# Validate necessary IAM permissions
validate_iam_permissions() {
    # Check IAM user permissions
    if ! aws iam get-user --user-name clusterManager &> /dev/null; then
        echo "IAM user 'clusterManager' does not exist. Please create it."
        exit 1
    fi

    # Check EKS cluster service role
    if ! aws iam get-role --role-name eksClusterRole &> /dev/null; then
        echo "EKS cluster service role 'eksClusterRole' does not exist. Please create it."
        exit 1
    fi

    # Check EKS node IAM role
    if ! aws iam get-role --role-name EKSNodeGroup &> /dev/null; then
        echo "EKS node IAM role 'EKSNodeGroup' does not exist. Please create it."
        exit 1
    fi

    # Check custom policies
    if ! aws iam get-policy --policy-arn arn:aws:iam::YOUR_ACCOUNT_ID:policy/EC2DescribeResourcesPolicy &> /dev/null; then
        echo "Custom policy 'EC2DescribeResourcesPolicy' does not exist. Please create it."
        exit 1
    fi
    if ! aws iam get-policy --policy-arn arn:aws:iam::YOUR_ACCOUNT_ID:policy/ChainstackPrivateHostingReadDescribePolicy &> /dev/null; then
        echo "Custom policy 'ChainstackPrivateHostingReadDescribePolicy' does not exist. Please create it."
        exit 1
    fi

    # Check clusterManager IAM user policies
    policies=$(aws iam list-attached-user-policies --user-name clusterManager --query 'AttachedPolicies[].PolicyName' --output text)
    required_policies=("AmazonVPCReadOnlyAccess" "IAMReadOnlyAccess" "ChainstackPrivateHostingReadDescribePolicy")
    for policy in "${required_policies[@]}"; do
        if ! echo "$policies" | grep -q "$policy"; then
            echo "Policy '$policy' is not attached to the clusterManager IAM user. Please attach it."
            exit 1
        fi
    done
}

# Validate EKS cluster creation
validate_eks_cluster() {
    # Check if the EKS cluster exists
    if ! aws eks describe-cluster --name YOUR_CLUSTER_NAME &> /dev/null; then
        echo "EKS cluster 'YOUR_CLUSTER_NAME' does not exist. Please create it."
        exit 1
    fi

    # Check if the EKS cluster is active
    cluster_status=$(aws eks describe-cluster --name YOUR_CLUSTER_NAME --query 'cluster.status' --output text)
    if [[ "$cluster_status" != "ACTIVE" ]]; then
        echo "EKS cluster 'YOUR_CLUSTER_NAME' is not active. Please wait for it to become active."
        exit 1
    fi
}

# Validate EKS node group creation
validate_eks_node_group() {
    # Check if the EKS node group exists
    if ! aws eks describe-nodegroup --cluster-name YOUR_CLUSTER_NAME --nodegroup-name YOUR_NODE_GROUP_NAME &> /dev/null; then
        echo "EKS node group 'YOUR_NODE_GROUP_NAME' does not exist. Please create it."
        exit 1
    fi

    # Check if the EKS node group is active
    node_group_status=$(aws eks describe-nodegroup --cluster-name YOUR_CLUSTER_NAME --nodegroup-name YOUR_NODE_GROUP_NAME --query 'nodegroup.status' --output text)
    if [[ "$node_group_status" != "ACTIVE" ]]; then
        echo "EKS node group 'YOUR_NODE_GROUP_NAME' is not active. Please wait for it to become active."
        exit 1
    fi
}

# Validate cert-manager installation
validate_cert_manager() {
    # Check if cert-manager is installed
    if ! helm list -n cert-manager &> /dev/null; then
        echo "cert-manager is not installed. Please install it using Helm."
        exit 1
    fi
}

# Validate EBS CSI installation
validate_ebs_csi() {
    # Check if EBS CSI driver is installed
    if ! kubectl get csidriver ebs.csi.aws.com &> /dev/null; then
        echo "EBS CSI driver is not installed. Please enable it."
        exit 1
    fi
}

# Validate prerequisites and permissions
validate_iam_permissions
validate_eks_cluster
validate_eks_node_group
validate_cert_manager
validate_ebs_csi

echo "All prerequisites and permissions are validated successfully."
