# install-kubernetes-on-gcp-mine.sh

COMPUTE_REGION=asia-northeast3
COMPUTE_ZONE=asia-northeast3-a
MYPROJECT=xxxx
NETWORK=k8s-cloudrobotics-gcp
SUBNET=k8s-subnet-node
INTERNAL_FIREWALL_RULE=k8s-cloudrobotics-gcp-allow-internal
EXTERNAL_FIREWALL_RULE=k8s-cloudrobotics-gcp-allow-external
NETWORK_ADDRESS=k8s-cloudrobotics-gcp
ROUTER=k8s-cloudrobotics-gcp-router
NAT=k8s-cloudrobotics-gcp-nat
install-kubernetes-on-gcp-mine.md


K8S_MASTER_CONTROLLER=k8s-cloudrobotics-gcp-controller


gcloud init
gcloud config list
gcloud config set compute/region asia-northeast3
gcloud config set compute/zone asia-northeast3-a
gcloud config set project ${MYPROJECT}

gcloud compute networks create k8s-cloudrobotics-gcp --subnet-mode custom

gcloud compute networks subnets create k8s-subnet-node \
 --network k8s-cloudrobotics-gcp \
 --range 10.240.0.0/24 

gcloud compute firewall-rules create k8s-cloudrobotics-gcp-allow-internal \
 --allow tcp,udp,icmp \
 --network k8s-cloudrobotics-gcp \
 --source-ranges 10.240.0.0/24


gcloud compute firewall-rules create k8s-cloudrobotics-gcp-allow-external \
 --allow tcp:22,tcp:6443,icmp \
 --network k8s-cloudrobotics-gcp \
 --source-ranges 0.0.0.0/0

gcloud compute addresses list
# 외부IP설정
gcloud compute addresses create k8s-cloudrobotics-gcp \
 --region $(gcloud config get-value compute/region)

PUBLIC_IP=$(gcloud compute addresses describe k8s-cloudrobotics-gcp \
--region $(gcloud config get-value compute/region) \
--format 'value(address)')

gcloud compute routers create k8s-cloudrobotics-gcp-router \
 --network k8s-cloudrobotics-gcp \
 --region asia-northeast3

gcloud compute routers nats create k8s-cloudrobotics-gcp-nat \
 --router-region asia-northeast3 \
 --router k8s-cloudrobotics-gcp-router \
 --nat-all-subnet-ip-ranges \
 --auto-allocate-nat-external-ips

# =======================================================

gcloud compute instances create k8s-cloudrobotics-gcp-controller \
--async \
--boot-disk-size 200GB \
--can-ip-forward \
--image-family ubuntu-2004-lts \
--image-project ubuntu-os-cloud \
--machine-type e2-standard-2 \
--private-network-ip 10.240.0.10 \
--scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
--subnet k8s-subnet-node \
--tags k8s-cloudrobotics-gcp,controller \
--address $PUBLIC_IP

gcloud compute instances list
