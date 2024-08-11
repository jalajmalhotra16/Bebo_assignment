Assignment1: Create a a custom solution using Python or Golang to clean up pods in a Kubernetes cluster that are in a bad state. Specifically, this involves creating a pod in the first namespace that runs a script to delete pods in the second namespace that meet the following criteria:
The pods are not running (i.e., failed/not scheduled).
The pods are older than 5 minutes.
The script will periodically check for such pods and delete them to maintain the health of the cluster.


Assignment2: Prepare a Terraform module to create a VPC
User only pass the CIDR for VPC, need to create logic which automatically create the private/public subnets, route table etc. by following the 3-tier architecture.
Include the NAT Gateway, Internet Gateway and option to integrate the Transit Gateway