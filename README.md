#### Cron job settings
- develop

   `*/5 * * * * cd /home/ec2-user/jotaay && git fetch  && git checkout deploy && git pull && /home/ec2-user/jotaay/edge_deploy.sh`
   
- staging

   `*/5 * * * * cd /home/ec2-user/jotaay && git fetch && git checkout deploy && git pull && /home/ec2-user/jotaay/stg_deploy.sh release && /home/ec2-user/jotaay/stg_deploy.sh hotfix`
   
- production

   `*/5 * * * * cd /home/ec2-user/jotaay && git fetch  && git checkout deploy && git pull && /home/ec2-user/jotaay/prod_deploy.sh` 