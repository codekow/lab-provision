# PXE config

## Dnsmasq config (tested on openwrt)

- [ ] Enable TFTP server
- [ ] TFTP server root - /mnt/sda1/tftpboot

```sh
# create symlink to use existing http
ln -s /mnt/sda1/tftpboot /www/tftpboot
```

```sh
# remove old pxe
sed '/^## pxe - start/,/^## pxe - end/d' /etc/dnsmasq.conf

# setup pxe
cat << EOF >> /etc/dnsmasq.conf
## pxe - start

# pxelinux options
# dhcp-option=211,600

# send disable multicast and broadcast discovery, and to download the boot file immediately
# dhcp-option=vendor:PXEClient,6,2b

# log-dhcp

# filenames, the first loads iPXE, and the second tells iPXE what to
# load. The dhcp-match sets the ipxe tag for requests from iPXE.
# Important Note: the 'set:' and 'tag:!ipxe' syntax requires dnsmasq 2.53 or above.
dhcp-match=ipxe,175

# set vendor class
dhcp-match=set:BIOS,option:client-arch,0
dhcp-match=set:EFI64,option:client-arch,7
dhcp-match=set:EFI64,option:client-arch,9
dhcp-match=set:EFI64-HTTP,option:client-arch,16

# other examples
# dhcp-boot=tag:BIOS,pxelinux.0
# dhcp-boot=tag:EFI64,tag:!ipxe,netboot/netboot.xyz.efi,,

# boot based on client arch
dhcp-boot=tag:BIOS,tag:!ipxe,ipxe/ipxe.pxe
dhcp-boot=tag:EFI64,tag:!ipxe,ipxe/ipxe.efi
#dhcp-boot=tag:EFI64,tag:!ipxe,shim.efi
dhcp-boot=tag:EFI64-HTTP,"http://gateway/tftpboot/ipxe/ipxe.efi"

# ipxe to load config
dhcp-boot=tag:ipxe,boot.ipxe

# tftp settings
tftp-no-fail
# tftp-no-blocksize
tftp-lowercase

# ocp wildcard example
# address=/api.ocp1.data.lab/192.168.5.91
# address=/apps.ocp1.data.lab/192.168.5.92

## pxe - end
EOF
```
