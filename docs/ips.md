# IP Allocation

## Production

| Application/Node          | Type               |             IP/CIDR             |
| ------------------------- | ------------------ | :-----------------------------: |
| keepalived                | VIP                |        192.168.1.200/32         |
| k8s-controlplane-01       | Control-Plane Node |        192.168.1.121/32         |
| k8s-controlplane-02       | Control-Plane Node |        192.168.1.122/32         |
| k8s-controlplane-03       | Control-Plane Node |        192.168.1.123/32         |
| k8s-node-01               | Node               |        192.168.1.131/32         |
| k8s-node-01               | Node               |        192.168.1.132/32         |
| k8s-node-01               | Node               |        192.168.1.133/32         |
| metallb                   | Daemonset          | 192.168.1.150 <-> 192.168.1.155 |
| istio                     | LoadBalancer       |        192.168.1.150/32         |
| coredns                   | LoadBalancer       |        192.168.1.151/32         |
| mosquitto                 | LoadBalancer       |        192.168.1.152/32         |
| zigbee2mqtt               | LoadBalancer       |        192.168.1.153/32         |
| zigbee2mqtt (code-server) | LoadBalancer       |        192.168.1.154/32         |

## Staging

| Application               | Type               |             IP/CIDR             |
| ------------------------- | ------------------ | :-----------------------------: |
| keepalived                | VIP                |        192.168.1.201/32         |
| k8s-controlplane-01       | Control-Plane Node |        192.168.1.111/32         |
| k8s-controlplane-02       | Control-Plane Node |        192.168.1.112/32         |
| k8s-controlplane-03       | Control-Plane Node |        192.168.1.113/32         |
| k8s-node-01               | Node               |        192.168.1.114/32         |
| k8s-node-01               | Node               |        192.168.1.115/32         |
| k8s-node-01               | Node               |        192.168.1.116/32         |
| metallb                   | Daemonset          | 192.168.1.160 <-> 192.168.1.165 |
| istio                     | LoadBalancer       |        192.168.1.160/32         |
| coredns                   | LoadBalancer       |        192.168.1.161/32         |
| mosquitto                 | LoadBalancer       |        192.168.1.162/32         |
| zigbee2mqtt               | LoadBalancer       |        192.168.1.163/32         |
| zigbee2mqtt (code-server) | LoadBalancer       |        192.168.1.164/32         |
