# OpenShift Setup

## Setup Enhanced Openshift Terminal

```sh
# apply firmly
until oc apply -k  https://github.com/redhat-na-ssa/ocp-web-terminal-enhanced/bootstrap; do : ; done

# delete old web terminal
$(wtoctl | grep 'oc delete')
```

## Setup `htpasswd`

```sh
htpasswd_...
```

## OpenShift Cluster Setup

```sh
oc apply -k components/cluster-configs/rbac/overlays/no-self-provisioner/
oc apply -k components/cluster-configs/login/overlays/htpasswd/
oc apply -k components/cluster-configs/namespaces/overlays/default-limited/
```
