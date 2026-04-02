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
  VM_MAC=${2:-52:54:00:4E:FF:00}
  VM_FILE=files/etc/libvirt/qemu/vm-00.xml

  sed '
      s/vm-00/'"${VM_NAME}"/g'
      s/52:54:00:4E:E0:00/'"${VM_MAC}"/g'
      ' "${VM_FILE}" > "scratch/${VM_NAME}".xml

}

lab_create_vm_set(){
  BASE_MAC=${BASE_MAC:-52:54:00:4E:FF}

  for i in {00..15}
  do
    # kludge for sh
    num=${i#0}
    lab_create_vm vm-"${i}" "${BASE_MAC}:$((num * 2 + 10))"
  done
}

lab_create_bmh(){
  VM_NAME=${1:-vm-00}
  VM_MAC=${2:-52:54:00:4E:FF:00}
  VM_HOST=${3:-nuc10-01}
  VM_FILE=files/ocp/bmh-00.yaml

  sed '
      s/vm-00/'"${VM_NAME}"/g'
      s/nuc10-01/'"${VM_HOST}"/g'
      s/52:54:00:4E:E0:00/'"${VM_MAC}"/g'
      ' "${VM_FILE}" > "scratch/${VM_NAME}"-bmh.yaml

}

lab_create_bmh_set(){
  BASE_MAC=${BASE_MAC:-52:54:00:4E:FF}
  BASE_HOST=${BASE_HOST:-nuc10}

  for i in {00..15}
  do
    # kludge for sh
    num=${i#0}
    lab_create_bmh vm-"${i}" "${BASE_MAC}:$((num * 2 + 10))" "${BASE_HOST}-${i}"
  done
}

lab_create_bmh_set_ab(){
  BASE_MAC=${BASE_MAC:-52:54:00:4E:E0}
  BASE_HOST=${BASE_HOST:-nuc10}

  num=0

  for i in {01..10}
  do
    # kludge for sh
    [ "$num" = "0" ] && num=${i#0}
    lab_create_bmh vm-"${i}a" "${BASE_MAC}:$((num * 2 + 10))" "${BASE_HOST}-${i}"
    num=$((num + 1))
    lab_create_bmh vm-"${i}b" "${BASE_MAC}:$((num * 2 + 10))" "${BASE_HOST}-${i}"
    num=$((num + 1))
  done
}

lab_uci_create_vm_dhcp(){
  VM_NAME=${1:-vm-00}
  VM_MAC=${2:-52:54:00:4E:FF:00}
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
  BASE_MAC="52:54:00:4E:FF"
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

iommu_get_groups(){
  [ -d /sys/kernel/iommu_groups/0 ] || return 0

  shopt -s nullglob
  for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V)
    do
      echo "IOMMU Group ${g##*/}:"
      for d in $g/devices/*; do
        echo -e "\t$(lspci -nns ${d##*/})"
    done
  done
}

redfish_query(){
  set -u

  which curl || return 0
  which jq || return 0

  # --- Configuration ---
  SUSHY_URL="${1:-https://nuc10-10.dav:8000}"
  SUSHY_AUTH="${2:-admin:alongpassword}"

  # ===========================================================
  # Query sushy-emulator for Redfish System IDs
  # Returns VM names and their Redfish URLs for install-config.yaml
  # ===========================================================

  echo "Querying Redfish emulator at $SUSHY_URL..."
  echo "---"

  # Get the list of all system URLs
  SYSTEM_PATHS=$(curl -sk -u "${SUSHY_AUTH}" "${SUSHY_URL}/redfish/v1/Systems/" | jq -r '.Members[]."@odata.id"')

  if [ -z "$SYSTEM_PATHS" ]; then
      echo "Error: Could not retrieve systems. Is sushy-emulator running at ${SUSHY_URL}"
      return 1
  fi

  # Loop through each system
  for path in $SYSTEM_PATHS; do
      FULL_URL="${SUSHY_URL}${path}"
      SYSTEM_ID=$(basename "$path")
      VM_NAME=$(curl -u "${SUSHY_AUTH}" -k -s "${FULL_URL}" | jq -r '.Name')
      POWER_STATE=$(curl -u "${SUSHY_AUTH}" -k -s "${FULL_URL}" | jq -r '.PowerState')
      ETH_PATH=$(curl -u "${SUSHY_AUTH}" -k -s "${FULL_URL}/EthernetInterfaces" | jq -r '.Members[0]."@odata.id"')
      MAC_ADDRESS=$(curl -u "${SUSHY_AUTH}" -k -s "${SUSHY_URL}${ETH_PATH}" | jq -r '.MACAddress')

      echo "VM Name:     ${VM_NAME}"
      echo "System ID:   ${SYSTEM_ID}"
      echo "Power State: ${POWER_STATE}"
      echo "MAC Address: ${MAC_ADDRESS}"
      echo "Redfish URL: redfish-virtualmedia${SUSHY_URL#http?}/redfish/v1/Systems/${VM_NAME}"
      echo "Redfish URL: redfish-virtualmedia${FULL_URL#http?}"
      echo "---"
  done
}
