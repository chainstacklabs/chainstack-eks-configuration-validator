<img width="1200" alt="Labs" src="https://user-images.githubusercontent.com/99700157/213291931-5a822628-5b8a-4768-980d-65f324985d32.png">

<p>
 <h3 align="center">Chainstack is the leading suite of services connecting developers with Web3 infrastructure</h3>
</p>

<p align="center">
  <a target="_blank" href="https://chainstack.com/build-better-with-ethereum/"><img src="https://github.com/soos3d/blockchain-badges/blob/main/protocols_badges/Ethereum.svg" /></a>&nbsp;  
  <a target="_blank" href="https://chainstack.com/build-better-with-bnb-smart-chain/"><img src="https://github.com/soos3d/blockchain-badges/blob/main/protocols_badges/BNB.svg" /></a>&nbsp;
  <a target="_blank" href="https://chainstack.com/build-better-with-polygon/"><img src="https://github.com/soos3d/blockchain-badges/blob/main/protocols_badges/Polygon.svg" /></a>&nbsp;
  <a target="_blank" href="https://chainstack.com/build-better-with-avalanche/"><img src="https://github.com/soos3d/blockchain-badges/blob/main/protocols_badges/Avalanche.svg" /></a>&nbsp;
  <a target="_blank" href="https://chainstack.com/build-better-with-fantom/"><img src="https://github.com/soos3d/blockchain-badges/blob/main/protocols_badges/Fantom.svg" /></a>&nbsp;
</p>

<p align="center">
  • <a target="_blank" href="https://chainstack.com/">Homepage</a> •
  <a target="_blank" href="https://chainstack.com/protocols/">Supported protocols</a> •
  <a target="_blank" href="https://chainstack.com/blog/">Chainstack blog</a> •
  <a target="_blank" href="https://docs.chainstack.com/quickstart/">Chainstack docs</a> •
  <a target="_blank" href="https://docs.chainstack.com/quickstart/">Blockchain API reference</a> • <br>
  • <a target="_blank" href="https://console.chainstack.com/user/account/create">Start for free</a> •
</p>

# Chainstack EKS Configuration Validator

This bash script validates the cluster permissions and prerequisites required for the Chainstack Amazon EKS Integration.

## Description

The script checks for the presence of necessary tools and validates the existence and status of IAM roles, policies, EKS cluster, node group, cert-manager, and EBS CSI driver.

- AWS CLI
- kubectl
- Helm
- IAM roles
- Policies
- EKS cluster
- Node group
- cert-manager
- EBS CSI driver

If any requirement is not met, the script will display an error message. If all requirements are met, it will display a success message.

## Quickstart

In the script, replace `YOUR_ACCOUNT_ID`, `YOUR_CLUSTER_NAME`, and `YOUR_NODE_GROUP_NAME` with your specific values.

1. Clone the repository
   git clone
2. Make the script executable by running `chmod + x validation_script.sh`.
3. Run the script with `./validation_script.sh`.

## Context

This script is designed to validate the setup for integrating Chainstack with an Amazon EKS cluster. The integration allows you to deploy all Chainstack-supported blockchain nodes and networks into your own Amazon EKS infrastructure.

The script checks for the setup and configuration of various components including IAM roles, policies, EKS cluster, node group, cert-manager, and EBS CSI driver. These components are necessary for the successful integration of Chainstack with Amazon EKS.

For a detailed guide on setting up an Amazon EKS cluster to integrate with Chainstack, please refer to the [Chainstack documentation](https://support.chainstack.com/hc/en-us/articles/900004174426).
