#### Cron job settings
- develop

   `*/5 * * * * /bin/bash -lc 'cd /home/ec2-user/jotaay && git checkout deploy && git pull && /home/ec2-user/jotaay/edge_deploy.sh'`
   
- staging

   `*/5 * * * * /bin/bash -lc 'cd /home/ec2-user/jotaay && git checkout deploy && git pull && /home/ec2-user/jotaay/stg_deploy.sh release >> /home/ec2-user/jotaay/log/deploy.log 2>&1 && /home/ec2-user/jotaay/stg_deploy.sh hotfix >> /home/ec2-user/jotaay/log/deploy.log 2>&1'`
   
- production

   `*/5 * * * * /bin/bash -lc 'cd /home/ec2-user/jotaay && git checkout deploy && git pull && /home/ec2-user/jotaay/prod_deploy.sh'` 