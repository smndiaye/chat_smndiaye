#### Prerequisite
- set local environment variables for packer
  - aws access key as `AWS_PACKER_TERRAFORM_ACCESS_KEY`
  - aws secret key as `AWS_PACKER_TERRAFORM_SECRET_KEY`
  
- set necessary terraform variables in `terraform/deploy_server/variables.tf` 
 
```
variable "aws_access_key" {
  default = "XXXXXXXXX"
}

variable "aws_secret_key" {
  default = "XXXXXXXXX"
}

variable "aws_region" {
  default = "ap-northeast-1"
}

variable "ssh_key_pub" {
default = "XXXXXXXXX"
}

```

- generate [github ssh key](https://help.github.com/articles/connecting-to-github-with-ssh/) and put private key as `packer/deploy_server/files/id_rsa`

  
#### Create deploy server AMI
- `sh packer/deploy_server/build_ami.sh`

#### Launch deploy server instance
- `cd terraform/deploy_server/`
- `sh launch_deploy_server.sh`
