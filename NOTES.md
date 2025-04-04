# Notes Dump

NVMe

```sh
# check for 4kn advanced format ability
sudo nvme id-ns -H /dev/nvme0n1
# change lba format
sudo nvme format --lbaf=1 /dev/nvme0n1 --format
```

Bridge Setup

```sh
bridge_config(){
  NIC=$(ls /sys/class/net/enp?s0)
  nmcli con add ifname br0 type bridge con-name br0
  nmcli con add type bridge-slave ifname "${NIC}" master br0
  nmcli con modify br0 bridge.stp no

  nmcli con down "${NIC}"
  nmcli con up br0
}

bridge_config &
```

## Links of interest

- [4KN Format NVME](https://carlosfelic.io/misc/how-to-switch-your-nvme-ssd-to-4kn-advanced-format/)
- [TPM Notes](https://tpm2-software.github.io/2020/06/12/Remote-Attestation-With-tpm2-tools.html)
- [Emulated Bare Metal w/ VMs](https://github.com/amedeos/ocp4-in-the-jars)
- [Sushy Tools](https://docs.openstack.org/sushy-tools/latest/admin/)
  - [More Notes](https://jgato.github.io/jgato/posts/redfish-sushy/)
  - [More Notes](https://gist.github.com/williamcaban/e5d02b3b7a93b497459c94446105872c)
  - [More Note](https://cloudcult.dev/sushy-emulator-redfish-for-the-virtualization-nation/)
- [Virtual BMC](https://docs.openstack.org/virtualbmc/latest/user/index.html)
  - [More Notes](https://www.cloudnull.io/2019/05/vbmc/)
- [GPU Passthrough](https://github.com/martinopiaggi/Single-GPU-Passthrough-for-Dummies)
- [Libvirt ArchLinux](https://wiki.archlinux.org/title/Libvirt#Server)
- [Libvirt Network](https://libvirt.org/formatnetwork.html)
- [Libvirt Docs](https://libvirt.org/docs.html)
- [FCOS Ignition](https://github.com/project-faros/cluster-manager/blob/master/app/roles/openshift-installer/templates/98-cache-disk.yaml.j2)
  - [More FCOS Ignition](https://coreos.github.io/ignition/getting-started)
- [Fedora Docs](https://docs.fedoraproject.org/en-US/fedora-coreos/live-booting)
- [Dracut SSH](https://github.com/dracut-crypt-ssh/dracut-crypt-ssh)
