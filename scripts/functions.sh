#!/bin/bash
  
[ -d scratch ] || mkdir scratch

lab_wol(){
  # MACS=()

  for nic in ${MACS[*]}
  do
    wol $nic
  done
}

lab_create_vm(){
  VM_NAME=${1:-00}
  VM_MAC=${2:-00}
  VM_FILE=files/etc/libvirt/qemu/vm-00.xml

  sed '
      s/vm-00/'"${VM_NAME}"/g'
      s/52:54:00:4e:e0:00/52:54:00:4e:e0:'"${VM_MAC}"/g'
      ' "${VM_FILE}" > "scratch/${VM_NAME}".xml

}

lab_create_vm_set(){

  for i in {00..10};
  do 
    lab_create_vm vm-"$i" "(($i * 2)"
  done
}
