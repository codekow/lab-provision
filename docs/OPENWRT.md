# OpenWrt Notes

## Links

- https://openwrt.org/docs/guide-user/advanced/expand_root

```sh
wget https://downloads.openwrt.org/releases/24.10.4/targets/x86/64/openwrt-24.10.4-x86-64-generic-ext4-combined-efi.img.gz

gunzip openwrt-*.gz

qemu-img create -f qcow2 -F raw -b openwrt-24.10.4-x86-64-generic-ext4-combined-efi.img router.lab.qcow2 2G
```
