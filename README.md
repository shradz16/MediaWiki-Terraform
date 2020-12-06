# MediaWiki-Terraform

This repo consists of Terraform files to create an AWS instance and security group

- AWS instance has provisioner chef which will install chef-client on the node and execute the cookbook mentioned in the runlist.
- Mediawiki cookbook will install and configure Mediwiki on the aws instance
- AMI select is of RHEL 8 since we are installing Mediawiki on RHEL8

TO use:
1. Install Terraform and AWICLI
2. Create a user and give programmatic access to it
3. Initialize terraform and run "terrafrom apply"
4. When prompted on screen, provide AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
5. To clean up and delete all resources after you're done, run "terraform destroy"

Note:
- Please change the keyname (and place it in a terraform initialized folder), region, subnet ID in the variable.tf file accordingly.
- Hosted chef server is used here, create your own chef account and replace server_url , user and key details.
