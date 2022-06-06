# Install kubernates on Google Cloud Platform
## Part5. Ch2. 10~11

## Setup VPC, Firewall, IP, Router
```
gcloud init
gcloud config list
gcloud compute networks create fastcampus-k8s --subnet-mode custom
gcloud compute networks subnets create k8s-nodes \
 --network fastcampus-k8s \
 --range 10.240.0.0/24 

gcloud compute firewall-rules create fastcampus-k8s-allow-internal \
 --allow tcp, udp, icmp, ipip \
 --network fastcampus-k8s \
 --source-ranges 10.240.0.0./24

gcloud compute firewall-rules create fastcampus-k8s-allow-external \
 --allow tcp:22, tcp:6443, icmp \
 --network fastcampus-k8s \
 --source-range 0.0.0.0/0

gcloud compute addresses list
gcloud compute addresses create fascampus-k8s  # 외부IP설정


gcloud compute routers create k8s-router \
 --network fastcampus-k8s \
 --region asia-northeast3

gcloud compute routers nats create k8s-nat \
 --router-region asia-northeast3 \
 --router k8s-router \
 --nat-all-subnet-ip-ranges \
 --auto-allocate-nat-external-ips
 ```
 
 ## Setup Master Node
 ```
 ```
 
 ## Setup Worker Node
 ```
 ```

