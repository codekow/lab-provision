# GPU Passthrough

## Nvidia

- https://www.techpowerup.com/vgabios/206557/asus-rtx2080-8192-181011

Download GPU ROM for Libvirt

```sh
curl -L -o /lib/firmware/Asus.RTX2080.8192.181011.rom https://www.techpowerup.com/vgabios/206557/Asus.RTX2080.8192.181011.rom
restorecon -Rv /lib/firmware/Asus.RTX2080.8192.181011.rom
```

Setup GPU ROM for Libvirt

```xml
<hostdev mode='subsystem' type='pci' managed='yes'>
    <driver name='vfio'/>
    <source>
    <address domain='0x0000' bus='0x17' slot='0x00' function='0x0'/>
    </source>
    <rom file='/lib/firmware/Asus.RTX2080.8192.181011.rom'/>
</hostdev>
```

