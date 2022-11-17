#!/bin/bash

NodeName=$(pvesh get /nodes --output-format json | jq -r '.[0].node')
VmList=$(pvesh get /nodes/"$NodeName"/qemu --output-format json)

echo "$VmList" |
jq --raw-output 'map([.name, .vmid, .status])[] | @tsv' |
while IFS=$'\t' read Name VmId Status; do
    echo "$Name | $VmId | $Status"

    if [ "$Status" == "running" ]; then
       BasePath="/nodes/$NodeName/qemu/$VmId"
       echo "Id: $VmId | Vm: $Name"

       VmIp=$(pvesh get "$BasePath"/agent/network-get-interfaces --output-format json |
        jq -r '.result[1]."ip-addresses"[0]."ip-address"')

       echo "Ip: $VmIp "

       ping -c 1 "$VmIp" &> /dev/null && Crashed=false || Crashed=true

       echo "IsCrashed: $Crashed"

       if [ "$Crashed" == true ]; then
          echo "Stopping Vm: $Name..."
          pvesh create "$BasePath"/status/stop
          sleep 5
          while $(pvesh get "$BasePath"/status/current --output-format json | jq -r '.status') == "running"; do
             echo "$Name is running yet..."
             sleep 5
          done
         echo "Starting Vm: $Name"
         pvesh create "$BasePath"/status/start
         echo "Vm $Name started"
       fi
    fi
done
