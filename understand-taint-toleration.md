# Kube Scheduler 
- Part5. 운영자를 위한 쿠버네티스 -> Ch3. Kubernetes 구성요소 -> 03.kube-scheduler


## taint & toleration
```
모든 노드에 taint 가 걸려있다면, 해당 deployment는 toleration이 없기때문에 스케쥴링이 되지 않음
노드에 taint를 걸어봄
```

```
kubectl taint nodes worker-0 color=red:NoSchedule
kubectl taint nodes worker-1 color=red:NoSchedule
kubectl taint nodes worker-2 color=red:NoSchedule
```
```
vi deployment.yaml
---
spec:
  template:
    spec:
      tolerations:
      - key: "color"
        operator: "Equal"
        value: "blue"
        effect: "NoSchedule"
---
 ==>  배포되지 않음 : toleration이 taint를 만족하지 않기 때문에

vi deployment.yaml
---
spec:
  template:
    spec:
      tolerations:
      - key: "color"
        operator: "Equal"
        value: "red"
        effect: "NoSchedule"
---
 ==> 배포됨 : taint 와 toleration이 일치하기 때문에
```

```
*어떤 pod를 자동으로 실행시키려면 아래 foler 에 yaml 파일을 저장함
/etc/kubernetes/manifests
이유:
/etc/kubernetes/kubelet-config.yaml
---
 staticpodPath : /etc/kubernetes/manifests
---
```
