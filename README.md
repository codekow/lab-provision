# lab-provision

A collection of provisioning scripts and files

## Quick starts

### Download the bins for tftpboot / pxe

```sh
cd files/tftpboot

. ../../scripts/update_bins.sh
```

### Examples for iPXE / kickstart

A kickstart that includes:

- Encrypts the root filesystem with `luks` and binds to a TPM with a random key
- Setup GitHub keys on user(s)
- `BIOS` vs `UEFI` detection
- Configures nested virtualization
- Installs `vbmcd` (virtualbmc) and `sushy-tools` for BMC / Redfish emulation

See [kickstart example](files/tftpboot/install/ks/ks-fedora-server.cfg)

iPXE example that includes:

- Check `iPXE` version and update
- Custom boot based on `hostname` or `mac` address with [client](files/tftpboot/boot.ipxe.cfg)
- Boot from `http` or `tftp`
- Boot `Memtest` or `netboot.xyz`

See [iPXE example](files/tftpboot/boot.ipxe)
