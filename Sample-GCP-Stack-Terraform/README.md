# PART 1:  Create Network ( VPC ) , Private and public subnetwork ( subnet ) with nat gateway.

# PART 2 : Deploying GCP VMs located in a private subnet, inside an unmanaged instance group, with a load balancer using Terraform

The script will install two Ubuntu instances with Apache web server located in private subnet, without public ip, inside an unmanaged instance group, with a load balancer using Terraform. 

lb.tf --> Create unmanaged instance group, backend services and all components required by the load balancer 

network-firewall.tf --> Configure basic firewall for the network

network-variables.tf --> Define network variables

network.tf --> Define network, vpc, subnet, icmp firewall

provider.tf --> Configure Google Cloud provider

terraform.tfvars --> Defining variables 

variables-auth.tf --> Application and authentication variables

vm.tf --> Create two Ubuntu VMs with Apache web server

# Notes

Check list of Google Cloud OS images --> https://cloud.google.com/compute/docs/images

Create the Json file for authentication --> https://cloud.google.com/iam/docs/creating-managing-service-account-keys

# Steps to run: Run below command from the same directory where terraform files are present after authentiation to gcloud:

	`terraform init`
	`terraform plan`
	`terraform apply`

# If you want to destroy  run below command :

	`terraform destroy`
