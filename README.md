#### Prerequisites
- set aws credentials for packer & terraform in `~/.aws/credentials`

  ```
  [jotaay]
  aws_access_key_id = XXXXXX
  aws_secret_access_key = XXXXXX
  ```
  
- set public ssh key that will be used to access the server as terraform variables in `terraform/deploy_server/variables.tf` 
 
  ```
  variable "ssh_key_pub" {
    default = "XXXXXXXXX"
  }
  ```

- generate [github ssh key](https://help.github.com/articles/connecting-to-github-with-ssh/) and put private key as `packer/deploy_server/files/id_rsa`

- create `terraform-state-jotaay-deploy-server` S3 bucket for terraform state locking
  
#### Create deploy server AMI
- `sh packer/deploy_server/build_ami.sh`

#### Launch deploy server instance
  - `cd terraform/deploy_server/`
  - `terraform get`
  - `AWS_PROFILE=jotaay terraform init`
  - `AWS_PROFILE=jotaay terraform import -lock=false aws_s3_bucket.terraform-state-storage-s3 terraform-state-jotaay-deploy-server`
  - `AWS_PROFILE=jotaay terraform apply -lock=false -auto-approve=false`

#### References
- [packer](https://www.packer.io/docs/index.html)
- [terraform](https://www.terraform.io/docs/index.html)
- [terraform locking state in S3](https://medium.com/@jessgreb01/how-to-terraform-locking-state-in-s3-2dc9a5665cb6)