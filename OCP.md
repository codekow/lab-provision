# OpenShift Setup

```sh
# apply firmly
until oc apply -k  https://github.com/redhat-na-ssa/ocp-web-terminal-enhanced/bootstrap; do : ; done

# delete old web terminal
$(wtoctl | grep 'oc delete')
```

```sh
oc apply -k components/cluster-configs/rbac/overlays/no-self-provisioner/
oc apply -k components/cluster-configs/login/overlays/htpasswd/
```
