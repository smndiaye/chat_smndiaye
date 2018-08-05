### AWS Solution Architect Associate Exam Cheat Sheet

Sharing here notes that I took when preparing for AWS SAA exam. Hope it helps. 

I also recommend to check following course: 

 [https://www.udemy.com/aws-certified-solutions-architect-associate/](https://www.udemy.com/aws-certified-solutions-architect-associate/)
 
Thanks to Ryan Kroonenburg for detailed explanations provided.
 
### Topics to focus on
  - Global Infrastructure
  - Security & Identity & Compliance
  - Storage
  - Migration
  - Compute
  - Networking & Content Delivery
  - Databases
  - Application Integration
     

### Global Infrastructure

- **AWS region**
	
	A region is a geographical area that consists of different availability zones. Each region has at least two Availability Zones.
	
- **Availability Zones**
	
   Distinct locations from within an AWS region that are engineered to be isolated from failures in other Availability Zones, and to provide inexpensive, low-latency network connectivity to other Availability Zones in the same region

- **What does an AWS Region consist of?**

   An independent collection of AWS computing resources in a defined geography.

- **Lambda**

   AWS service that allows to run code without having to worry about provisioning any underlying resources (such as virtual machines, databases, etc.)
	

- **VPC**
  
   Virtual Private Cloud (a component of AWS Networking Service)

- **Elastic Beanstalk**

   AWS service specifically designed to run a developer's code on an infrastructure that is automatically provisioned to host that code
   
- **Difference between Elastic Beanstalk & CloudFormation**
	
	Elastic Beanstalk automatically handles the deployment, from capacity provisioning, load balancing, auto-scaling to application health monitoring based on the code you upload to it, where as CloudFormation is an automated provisioning engine designed to deploy entire cloud environments via a JSON script. 

- **Route 53**

   Amazon's highly scaleable DNS service.

- **Elastic Map Reduce (EMR)**

   AWS compute service specifically designed for large data sets processing

- **CloudFront**

   AWS service that used a CDN to distribute content around the world

- **S3**

   AWS solution that offers durable, available storage for flat files

- **Glacier**

   AWS services for long term data archival

- **Relational Database Services (RDS)**

  - SQL, 
  - MySQL, 
  - MariaDB, 
  - PostgreSQL, 
  - Aurora, 
  - Oracle

- **Redshift**

   AWS services for data warehousing
	
- **Kinesis**

   AWS service for collating large amounts of data streamed from multiple sources

- **Identity Access Management (IAM)**

	- Manage access to AWS services and resources securely.
	- Create and manage AWS users and groups, and use permissions to allow and deny their access to AWS resources. 

- **CloudTrail**

	Auditors with logs detailing the individual users that provision specific resources on AWS platform.
	
- **Opsworks**

	Configuration management service that provides managed instances of Chef and Puppet. Chef and Puppet are automation platforms that allow you to use code to automate the configurations of your servers. OpsWorks lets you use Chef and Puppet to automate how servers are configured, deployed, and managed across your Amazon EC2 instances or on-premises compute environments.

- **Elastic Transcoder**

	Convert media files in to different formats to suit different devices

### Security & Identity & Compliance

**IAM: Identity and Access Management**

- The AWS web service that allows to create users and groups and set permissions
- IAM is universal. It does not apply to regions at this time

**User**

- A human being, system or application

**Group**

- A way to group users together and apply policies to them collectively
- A list of Users. 
- Examples of Groups might be:
    * Administrators
    * System operations
    * Developers
       
**Role**
	
- AWS identity with permission policies that determine what the identity can and cannot do in AWS.
- A user can assume a role for a period of time between 15 minutes and 1 hour.

**Policy**

- This is a JSON document describing permissions or rights that you can grant to a User, Group or Role that define what tasks users are allowed to perform.
    
        {
          "Version": "2012-10-17",
          "Statement": [{
              "Effect": "Allow",
              "Action": "*",
              "Resource": "*"
           }]
        }

### Storage

**S3: Simple Storage Service**

- S3 is object based (allows to upload files) unlike block based (database storage for example)
- Files can be from 0 Bytes to 5TB
- Storage is unlimited
- Files are stored in buckets
	- a bucket is just a folder in the cloud that has universal namespace (a bucket name is unique globally)
   - bucket name example: **https://s3-ap-northeast-1.amazonaws.com/monstarlab.private**
   - by default buckets are private and all objects stored inside them are private
   - control access to buckets using ACL or using bucket policies
	
- Objects consist of the following:
	- key: name of the object
	- value: data (sequence of bytes)
	- version ID: important for versioning
	- metadata: data about data you are storing (tags, …)
	- subresources
		- access control list: set who can access an object
		- torrent

- Read after Write consistency for PUTS of new Objects
- Eventual consistency for overwrite PUTS and DELETES (can take time to propagate)
- Storage Tiers/Classes
	- S3 Standard
	- S3- IA (infrequently access)
	- S3 One Zone - IA (Reduced Redundancy): only in one az
	- Glacier: archived data, where you can wait 3-5hours before accessing

- Charged for
	- storage
	- requests
	- storage management pricing
	- data transfer pricing: from one region to another
	- transfer acceleration: using edge locations to find optimum path

- Version Control
	- feature that keeps track of and store old and new versions of objects. Stores all versions including all writes and even deletes
	- great backup tool
	- versioning is only on or off
	- once its turned on you can only suspend it (prevent forward versioning)
	- possibility to set MFA Delete for version change and deletion

- Cross Region Replication
	- versioning must be enabled on both source and destination buckets
	- cross region replication applied only to new objects and updated files 
	- when deleting object, delete marker is replicated across regions
	- when delete marker is deleted its not replicated  

- Lifecycle Management, S3 - IA & Glacier
	- automatique transition between storage tiers/classes
	- can be applied with or without versioning


- Encryption [参考](https://sepior.com/blog/2017/3/20/encrypting-data-on-amazon-s3)
	- in transit: ssl/tls
	- at rest:
		- server side encryption SSE
			- S3 managed keys: SSE-S3     
			- AWS KMS: SSE-KMS
			- Server side encryption with customer provided keys: SSE-C
		- client side

- Storage Gateway
	- File Gateway: for flat files, stored directly on S3
	- Volume Gateway
		- Stored Volumes: entire dataset is stored on site and is asynchronously backed up to S3
		- Cached Volumes: entire dataset is stored on S3 and the most frequently accessed data is cached on site
	- Gateway Virtual Tape Library (VTL)
		- used for backup and uses popular backup applications like NetBackup, Veer, etc.

- S3 Transfer Acceleration
	- utilizes CloudFront Edge Network to accelerate uploads to S3. 
	- instead of uploading directly to S3 bucket, uses a distinct URL to upload directly to an edge location which then will transfer it to S3

**Note** [参考](https://acloud.guru/forums/aws-certified-solutions-architect-associate/discussion/-KafpnxYX5mLeX31q15Q/aws-cloufront-vs-s3-transfer-acceleration)

S3 Transfer Acceleration uses the same optimized network path that the global distribution of edge locations use. However, there is a big difference between the CloudFront and Transfer Acceleration.
When we request an object from S3, and it is set up with CloudFront CDN, the request would come through the Edge Location transfer paths only for the first request. Thereafter, it would be served from the edge location nearest to the user till it expires.

On the other hand, when we request an object from S3 with Transfer Acceleration, it would arrive at our location using the Edge Location transfer paths every time we request for it. There are no local cache for subsequent retrieval. Moreover, if there is no significant improvement in retrieval time, then AWS may bypass transfer acceleration - the object could be transferred using normal transfer path, and we wouldn't be charged for accelerated transfer in that case.

### Migration
- Snowball: Import to /Export from S3
	- snowball: storage
	- snowball edge: storage + compute capacity
	- snowmobile: literally a truck for extremely large amount of data

### Compute 

**EC2: Elastic Computer Cloud**
		
- Options: 
	- On Demand
	- Reserved: 1 or 3 years terms
	- Spot: 
		- application that have flexible start and end times
		- for user with a urgent need of large amounts of additional compute capacities
	- Dedicated Hosts
		- [ec2-dedicated-instances](https://aws.amazon.com/blogs/aws/amazon-ec2-dedicated-instances/)
		- [ec2-dedicated-hosts](https://aws.amazon.com/blogs/aws/now-available-ec2-dedicated-hosts/)

		An Amazon EC2 Dedicated host is a physical server with EC2 instance capacity dedicated for your use and allows you to reliably launch EC2 instances on the same Dedicated host over time. You have visibility over how your Dedicated hosts are utilized and you can determine how many sockets and cores are installed on the server. These features allow you to minimize licensing costs in a bring-your-own-license (BYOL) scenario and help you address corporate compliance and regulatory requirements.

- Instance Types: FIGHTDRMCPX

    
        F  fpga
        I  iops
        G  graphics
        H  high disk throughput
        T  cheap general purpose
        D  density
        R  ram
        M  main for general purpose
        C  compute
        P  graphics
        X  extreme memory
    

- Instance Metadata
	- curl 169.254.169.254/latest/meta-data/	
- EBS
	- SSD
		- general purpose ssd:  can be boot volume
		- provisioned IOPS ssd:  can be boot volume
	- Magnetic
		- throughput optimized hdd
		- cold hhd
		- magnetic: can be boot volume

- RAID, Volumes & Snapshots
	- better stop instance to take root volume snapshot
	- volume and EC2 must be in the same AZ
	- to move EC2 volume across region first take a snapshot or create an image then copy it
	- you can share snapshots but only if they are not encrypted
	- RAID levels: redundant array of independent disks [参考](https://linuxacademy.com/blog/linux/raid-explained/)
		- RAID 0
		- RAID 1
		- RAID 5
		- RAID 10

- EBS VS Instance Stored
   - EBS is like the virtual disk of a VM:
     * Durable, instances backed by EBS can be freely started and stopped (saving money)
     * Can be snapshotted at any point in time, to get point-in-time backups
     * AMIs can be created from EBS snapshots, so the EBS volume becomes a template for new systems

  - Instance storage is:
     * Local, so generally faster
     * Non-networked, in normal cases EBS I/O comes at the cost of network bandwidth (except for EBS-optimized instances, which have separate EBS bandwidth)
     * Has limited I/O per second IOPS. Even provisioned I/O maxes out at a few thousand IOPS
     * Fragile. As soon as the instance is stopped, you lose everything in instance storage.
          
  - Usage ?
     * Use EBS for backing OS partition and permanent storage (DB data, critical logs, application config)
     * Use instance storage for in-process data, noncritical logs, and transient application state. Example: external sort storage, tempfiles, etc.
     * Instance storage can also be used for performance-critical data, when there's replication between instances (NoSQL DBs, distributed queue/message systems, and DBs with replication)
     * Use S3 for data shared between systems: input dataset and processed results, or for static data used by each system when lauched.
     * Use AMIs for prebaked, launchable servers



- EC2 placement group [参考](http://jayendrapatil.com/aws-ec2-placement-groups/)
    * Logical grouping of instances within a single Availability Zone
    * Using Placement Groups enables applications to participate in a low-latency, 10 Gbps network
    * Instances within a Placement Group will benefit from minimized latency and maximized throughput of the network
The limitations of using a Placement Group are:
    * Not all of the instance types that can be launched into a placement group can take full advantage of the 10 gigabit network speeds provided
    * You can't move an existing instance into a placement group
    * You can't merge placement groups.
    * Although launching multiple instance types into a placement group is possible, this reduces the likelihood that the required capacity will be available for your launch to succeed


- EFS [参考](https://dzone.com/articles/confused-by-aws-storage-options-s3-ebs-amp-efs-explained)

### Networking & Content Delivery

**VPC: Virtual Private Cloud**

- Route 53

   - terms
     - **top level domain name**:  .jp  of .co.jp
     - **second level domain name**:  .co  of .co.jp
     - **start of authority (SOA) record**: information stored in a domain name system (DNS) zone about that zone and about other DNS records. A DNS zone is the part of a domain for which an individual DNS server is responsible. Each zone contains a single SOA record. SOA records are defined in IETF RFC 1035, Domain Names - Implementation and Specification. The SOA record stores information about the name of the server that supplied the data for the zone; the administrator of the zone; the current version of the data file; the number of seconds a secondary name server should wait before checking for updates; the number of seconds a secondary name server should wait before retrying a failed zone transfer; the maximum number of seconds that a secondary name server can use data before it must either be refreshed or expire; and a default number of seconds for the time-to-live file on resource records.
     - **A record**: most basic type of DNS record and is used to point a domain or subdomain to an IP address
     - **CNAME (canonical name record)**: record that points to another domain address rather than an IP address
     - **Alias record**: Alias records are used to map resource record sets in your hosted zone to Amazon Elastic Load Balancing load balancers, Amazon CloudFront distributions, AWS Elastic Beanstalk environments, or Amazon S3 buckets that are configured as websites. Alias records have two advantages: first, unlike CNAMEs, you can create an Alias record for your zone apex (e.g. example.com, instead of www.example.com), and second, queries to Alias records are free of charge.
  
  - Routing Policies:
  	- **Simple routing policy**: for a single resource that performs a given function for your domain, for example, a web server that serves content for the example.com website.
	- **Failover routing policy**: when you want to configure active-passive failover.
	- **Geolocation routing policy**: when you want to route traffic based on the location of your users.
	- **Geoproximity routing policy**: when you want to route traffic based on the location of your resources and, optionally, shift traffic from resources in one location to resources in another.
	- **Latency routing policy**: when you have resources in multiple AWS Regions and you want to route traffic to the region that provides the best latency.
	- **Multivalue answer routing policy**: when you want Route 53 to respond to DNS queries with up to eight healthy records selected at random.
	- **Weighted routing policy**: for routing traffic to multiple resources in proportions that you specify.

- **CloudFront**
	- **CDN**: A content delivery network (CDN) is a system of distributed servers (network) that deliver pages and other Web content to a user, based on the geographic locations of the user, the origin of the webpage and the content delivery server.
	- **Edge Location**: location where content will be cached (with a TTL default to 24hrs)
	- possibility to clear caches (you will be charged for this)
	- Edge Locations are not just READ only, you can write to them too
	- **Origin**: origin of files that the CDN will distribute (S3 Bucket, EC2 instance, ALB, Route53)
	- **Distribution**: Name given to the CDN which consists of a collection of edge locations
		- Web Distribution: websites
		- RTMP Distribution: media streaming
		
- **SG: Security Group**
	- all inbound traffic is blocked by default
	- all outbound traffic is allowed by default
	- changes take effect immediately
	- one SG for multiple instances
	- one EC2 for multiples SGs
	- SGs are stateful: any inbound rule allows its outbound effect (unlike NACLs)
	- one cannot block specific IP using SG

- **NACL**
   
   optional layer of security for your VPC that acts as a firewall for controlling traffic in and out of one or more subnets
   
   - Your VPC automatically comes with a modifiable default network ACL. By default, it allows all inbound and outbound IPv4 traffic and, if applicable, IPv6 traffic.
   
   - You can create a custom network ACL and associate it with a subnet. By default, each custom network ACL denies all inbound and outbound traffic until you add rules.
   
   - Each subnet in your VPC must be associated with a network ACL. If you don't explicitly associate a subnet with a network ACL, the subnet is automatically associated with the default network ACL.
   
   - You can associate a network ACL with multiple subnets; however, a subnet can be associated with only one network ACL at a time. When you associate a network ACL with a subnet, the previous association is removed.
   
   - A network ACL contains a numbered list of rules that we evaluate in order, starting with the lowest numbered rule, to determine whether traffic is allowed in or out of any subnet associated with the network ACL. The highest number that you can use for a rule is 32766. We recommend that you start by creating rules in increments (for example, increments of 10 or 100) so that you can insert new rules where you need to later on.
   
   - A network ACL has separate inbound and outbound rules, and each rule can either allow or deny traffic.

Network ACLs are stateless; responses to allowed inbound traffic are subject to the rules for outbound traffic (and vice versa).

- **ELB, ALB & NLB**
	- no public IP for LB, DNS name instead
	- [aws-elb-clb-vs-alb-vs-nlb](https://jackiechen.org/2018/01/10/aws-elb-clb-vs-alb-vs-nlb/)
	
- **Launch Configuration and AutoScaling** [参考](http://www.cardinalpath.com/autoscaling-your-website-with-amazon-web-services-part-2/)

### Databases [参考](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/)

- RDS (SQL, MySQL, MariaDB, PostgreSQL, Aurora, Oracle)
   - the basic building block of Amazon RDS is the DB instance
   
   - a DB instance is an isolated database environment in the cloud
   
   - DB instance storage comes in three types: Magnetic, General Purpose (SSD), and Provisioned IOPS (PIOPS)
   
   - shell (root ssh) access is not provided

   - support encryption at rest using KMS as well as encryption in transit using SSL endpoints
   
   - logs, snapshots, backups, read replicas of an encrypted database are encrypted
   
   - Amazon RDS uses DB security groups, VPC security groups, and EC2 security groups. In simple terms, a DB security group controls access to a DB instance that is not in a VPC, a VPC security group controls access to a DB instance inside a VPC, and an Amazon EC2 security group controls access to an EC2 instance and can be used with a DB instance
   
   - Amazon RDS provides high availability and failover support for DB instances using Multi-AZ deployments.

   - In a Multi-AZ deployment, Amazon RDS automatically provisions and maintains a synchronous standby replica in a different Availability Zone. The primary DB instance is synchronously replicated across Availability Zones to a standby replica to provide data redundancy, eliminate I/O freezes, and minimize latency spikes during system backups. Running a DB instance with high availability can enhance availability during planned system maintenance, and help protect your databases against DB instance failure and Availability Zone disruption.

   - Amazon Aurora instances stores copies of the data in a DB cluster across multiple Availability Zones in a single AWS Region, regardless of whether the instances in the DB cluster span multiple Availability Zones.

   - Amazon RDS uses the MariaDB, MySQL, and PostgreSQL (version 9.3.5 and later) DB engines' built-in replication functionality to create a special type of DB instance called a Read Replica from a source DB instance. Updates made to the source DB instance are asynchronously copied to the Read Replica. You can reduce the load on your source DB instance by routing read queries from your applications to the Read Replica. Using Read Replicas, you can elastically scale out beyond the capacity constraints of a single DB instance for read-heavy database workloads.
  
- DynamoDB

   - Nonrelational database that delivers reliable performance at any scale. It's a fully managed, multi-region, multi-master database that provides consistent single-digit millisecond latency, and offers built-in security, backup and restore, and in-memory caching.
   - Read Consistency
   		- Eventually Consistent Reads (default)
   		- Strongly Consistent Reads
   - DAX is a DynamoDB-compatible caching service that enables you to benefit from fast in-memory performance for demanding applications. DAX addresses three core scenarios:
   
   	   - As an in-memory cache, DAX reduces the response times of eventually-consistent read workloads by an order of magnitude, from single-digit milliseconds to microseconds.
   	   
   	   - DAX reduces operational and application complexity by providing a managed service that is API-compatible with Amazon DynamoDB, and thus requires only minimal functional changes to use with an existing application.
   	   
   	   - For read-heavy or bursty workloads, DAX provides increased throughput and potential operational cost savings by reducing the need to over-provision read capacity units. This is especially beneficial for applications that require repeated reads for individual keys.
   	   
   	- Capacity Unit Sizes
   	
   	 - **One read capacity unit** = one strongly consistent read per second, or two eventually consistent reads per second, for items up to **4 KB** in size.
   	
   	 - **One write capacity unit** = one write per second, for items up to **1 KB** in size.
   	
   	- Provisioned Throughput Default Limits

     - For any table or global secondary index, the minimum settings for provisioned throughput are 1 read capacity unit and 1 write capacity unit.
     - US East (N. Virginia) Region:

       - Per table – 40,000 read capacity units and 40,000 write capacity units
       - Per account – 80,000 read capacity units and 80,000 write capacity units
     
     - All Other Regions:
     
       - Per table – 10,000 read capacity units and 10,000 write capacity units
       - Per account – 20,000 read capacity units and 20,000 write capacity units


   
- ElastiCache

   Web service that makes it easy to set up, manage, and scale distributed in-memory cache environments in the AWS Cloud
   
   - **Amazon ElastiCache for Redis:**
   
     - Automatic detection and recovery from cache node failures.
      
     - Multi-AZ with automatic failover of a failed primary cluster to a read replica in Redis clusters that support replication.
     
     - Redis (cluster mode enabled) supports partitioning your data across up to 15 shards.
     
     - Redis version 3.2.6 supports in-transit and at-rest encryption with authentication so you can build HIPAA-compliant applications.
     
     - Flexible Availability Zone placement of nodes and clusters for increased fault tolerance.
     
     - Integration with other AWS services such as Amazon EC2, Amazon CloudWatch, AWS CloudTrail, and Amazon SNS to provide a secure, high-performance, managed in-memory caching solution.

   - **ElastiCache for Memcached:**

   	  - Automatic detection and recovery from cache node failures.
   	  
   	  - Automatic discovery of nodes within a cluster enabled for automatic discovery, so that no changes need to be made to your application when you add or remove nodes.
   	  
   	  - Flexible Availability Zone placement of nodes and clusters.

   	  - Integration with other AWS services such as Amazon EC2, Amazon CloudWatch, AWS CloudTrail, and Amazon SNS to provide a secure, high-performance, managed in-memory caching solution

   - **Choose Memcached if the following apply for you:**
   
   		- You need the simplest model possible.

   		- You need to run large nodes with multiple cores or threads.
   		
   		- You need the ability to scale out and in, adding and removing nodes as demand on your system increases and decreases.
   		
   		- You need to cache objects, such as a database.
   		
- Redshift

	- An Amazon Redshift data warehouse is an enterprise-class relational database query and management system.
	- Amazon Redshift supports client connections with many types of applications, including business intelligence (BI), reporting, data, and analytics tools.
	- possibility to load data into Amazon Redshift database tables from data files in an Amazon Simple Storage Service (Amazon S3) bucket
	- Amazon Redshift achieves extremely fast query execution by employing:
		- Massively Parallel Processing
		- Columnar Data Storage
		- Data Compression
		- Query Optimizer
		- Result Caching
		- Compiled Code

### Application Integration

- Amazon Simple Notification Service (Amazon SNS)

	- web service that coordinates and manages the delivery or sending of messages to subscribing endpoints or clients.
	- two types of clients
		- publishers (producers)
		   
		   publishers communicate asynchronously with subscribers by producing and sending a message to a topic, which is a logical access point and communication channel. 
		   
		- subscribers (consumers)
	  
	      subscribers (i.e., web servers, email addresses, Amazon SQS queues, AWS Lambda functions) consume or receive the message or notification over one of the supported protocols (i.e., Amazon SQS, HTTP/S, email(plain or JSON), SMS, Lambda) when they are subscribed to the topic.
	- order is not guaranteed
	- ability to send push notification messages directly to apps on mobile devices.
	
- Amazon Simple Queue Service (Amazon SQS)
	
	- secure, durable, and available hosted queue that lets you integrate and decouple distributed software systems and components
	- benefits:
	
		- **Security** – You control who can send messages to and receive messages from an Amazon SQS queue. Server-side encryption (SSE) lets you transmit sensitive data by protecting the contents of messages in queues using keys managed in AWS Key Management Service (AWS KMS).
		
		- **Durability** – To ensure the safety of your messages, Amazon SQS stores them on multiple servers. Standard queues support at-least-once message delivery, and FIFO queues support exactly-once message processing.
		
		- **Availability** – Amazon SQS uses redundant infrastructure to provide highly-concurrent access to messages and high availability for producing and consuming messages.
		
		- **Scalability** – Amazon SQS can process each buffered request independently, scaling transparently to handle any load increases or spikes without any provisioning instructions.
		
		- **Reliability** – Amazon SQS locks your messages during processing, so that multiple producers can send and multiple consumers can receive messages at the same time.
		
		- **Customization** – Your queues don't have to be exactly alike—for example, you can set a default delay on a queue. You can store the contents of messages larger than 256 KB using Amazon Simple Storage Service (Amazon S3) or Amazon DynamoDB, with Amazon SQS holding a pointer to the Amazon S3 object, or you can split a large message into smaller messages.
	- Standard Queue
		- **Unlimited Throughput** – Standard queues support a nearly unlimited number of transactions per second (TPS) per action.
		
		- **At-Least-Once Delivery** – A message is delivered at least once, but occasionally more than one copy of a message is delivered.
		
		- **Best-Effort Ordering** – Occasionally, messages might be delivered in an order different from which they were sent.
	- FIFO Queue
		- **High Throughput** – By default, FIFO queues support up to 3,000 messages per second with batching. To request a limit increase, file a support request. FIFO queues support up to 300 messages per second (300 send, receive, or delete operations per second) without batching.
		
		- **Exactly-Once Processing** – A message is delivered once and remains available until a consumer processes and deletes it. Duplicates aren't introduced into the queue.
		
		- **First-In-First-Out Delivery** – The order in which messages are sent and received is strictly preserved.  
	- holds message for 4 days, by default (can be changed to a value between 1 min – 14 days)
	- possibility to use server-side encryption (SSE) to protect the contents of messages using keys managed in AWS Key Management Service (AWS KMS).
	- visibility timeout
	
		Immediately after a message is received, it remains in the queue. To prevent other consumers from processing the message again, Amazon SQS sets a visibility timeout, a period of time during which Amazon SQS prevents other consumers from receiving and processing the message. The default (minimum) visibility timeout for a message is 30 seconds. The maximum is 12 hours.
	
	- short polling
		 - when the WaitTimeSeconds parameter of a ReceiveMessage request is set to 0
	- long polling
		- eliminate empty responses by allowing Amazon SQS to wait until a message is available in a queue before sending a response
		
- Amazon Simple Workflow Service (Amazon SWF)

	makes it easier to develop asynchronous and distributed applications by providing a programming model and infrastructure for coordinating distributed components and maintaining their execution state in a reliable way
