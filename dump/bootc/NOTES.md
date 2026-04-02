# Kickstart Information

`bootc` resources

- https://github.com/kincl/fedora-zfs-server
- https://git.jharmison.com/james/bootc-image

`bootc` kickstart example

```sh
# Basic setup
text
network --bootproto=dhcp --device=link --activate

#clearpart --all --drives=/dev/disk/by-path/pci-0000:00:1f.2-ata-1
#bootloader --location=mbr --boot-drive=disk/by-path/pci-0000:00:1f.2-ata-1
#part / --grow --fstype xfs --ondisk=/dev/disk/by-path/pci-0000:00:1f.2-ata-1
#reqpart --add-boot

rootpw --plaintext root

ostreecontainer --url quay.io/fedora/fedora-bootc:42

firewall --disabled
services --enabled=sshd

lang en_US.UTF-8
keyboard us
timezone --utc UTC
```
