# Kube APISERVER 접속
- ref: Part5. 운영자를 위한 쿠버네티스 -> Ch3. Kubernetes 구성요소 -> 02.kube-apiserver


0) curl https://10.177.191.47:6443 접속안됨.

1) 쿠버네티스 클러스터에서 제공하는 클러스터 CA Cert 를 Kubeconfig 에서 획득한 다음에 요청을 날림
```
kubectl config view --minify --raw
kubectl config view --minify --raw --output 'jsonpath={ ..cluster.certificate-authority-data}
kubectl config view --minify --raw --output 'jsonpath={ ..cluster.certificate-authority-data}' | base64 -d 
kubectl config view --minify --raw --output 'jsonpath={ ..cluster.certificate-authority-data}' | base64 -d > cluster-ca.crt
```

2) User  에 대한 Key, Cert 정보 획득
```
kubectl config view --minify --raw --output 'jsonpath={ ..user.client-certificate-data}'
kubectl config view --minify --raw --output 'jsonpath={ ..user.client-certificate-data}' | base64 -d
kubectl config view --minify --raw --output 'jsonpath={ ..cluster.certificate-authority-data}' | base64 -d > user.cert

kubectl config view --minify --raw --output 'jsonpath={ ..user.client-key-data}'
kubectl config view --minify --raw --output 'jsonpath={ ..user.client-key-data}' | base64 -d
kubectl config view --minify --raw --output 'jsonpath={ ..user.client-key-data}' | base64 -d > user.key
```

3)  APISERVER 에 api 요청하기
```
curl --cacert cluster-ca.crt https://10.177.191.47:6443
curl --cacert cluster-ca.crt --cert user.crt --key user.key https://10.177.191.47:6443
curl -X GET https://10.177.191.47:6443 --cacert cluster-ca.crt --cert user.crt --key user.key
```
