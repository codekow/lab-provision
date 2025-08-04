#!/bin/bash
  
[ -d scratch ] || mkdir scratch

lab_wol(){
  # MACS=()

  for nic in ${MACS[*]}
  do
    wol "$nic"
  done
}

lab_create_vm(){
  VM_NAME=${1:-vm-00}
  VM_MAC=${2:-52:54:00:4E:E0:00}
  VM_FILE=files/etc/libvirt/qemu/vm-00.xml

  sed '
      s/vm-00/'"${VM_NAME}"/g'
      s/52:54:00:4e:e0:00/'"${VM_MAC}"/g'
      ' "${VM_FILE}" > "scratch/${VM_NAME}".xml

}

lab_create_vm_set(){
  BASE_MAC="52:54:00:4E:E0"

  for i in {00..10};
  do
    # kludge for sh
    num=${i#0}
    lab_create_vm vm-"${i}" "${BASE_MAC}:$((num * 2 + 10))"
  done
}

lab_uci_create_vm_dhcp(){
  VM_NAME=${1:-vm-00}
  VM_MAC=${2:-52:54:00:4E:E0:00}
  VM_IP=${3:-10.105.0.100}
  VM_LEASE=${4:-5m}

  uci add dhcp host
  uci set dhcp.@host[-1].name="${VM_NAME}"
  uci add_list dhcp.@host[-1].mac="${VM_MAC}"
  uci set dhcp.@host[-1].ip="${VM_IP}"
  uci set dhcp.@host[-1].leasetime="${VM_LEASE}"
  uci set dhcp.@host[-1].dns='1'
}

lab_uci_setup(){
  BASE_MAC="52:54:00:4E:E0"
  BASE_IP="10.105.0"
  BASE_IP_START=61
  BASE_START=00
  BASE_END=10

  for i in $(seq -w ${BASE_START} ${BASE_END})
  do
    # kludge for sh
    num=${i#0}
    lab_uci_create_vm_dhcp vm-"${i}" "${BASE_MAC}:$((num * 2 + 10))" "${BASE_IP}.$((num + BASE_IP_START))"
  done
}
