#!/bin/bash

VM_NAME=$1

ISO_PATH="${HOME}/Downloads/CentOS-7-x86_64-Everything-1511.iso"
ISO_PATH="${HOME}/Downloads/CentOS-7-x86_64-Minimal-1511.iso"

VBOX_HOME="${HOME}/VirtualBox VMs"

VM_HD_PATH="${VBOX_HOME}/${VM_NAME}/sda.vdi" # The path to VM hard disk (to be created).

SHARED_PATH=~ # Share home directory with the VM


vboxmanage createvm --name $VM_NAME --ostype "RedHat_64" --register
vboxmanage storagectl $VM_NAME --name "SATA Controller" --add sata --controller IntelAHCI
vboxmanage createhd --filename "$VM_HD_PATH" --size 32768
vboxmanage storageattach $VM_NAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VM_HD_PATH"
vboxmanage storagectl $VM_NAME --name "IDE Controller" --add ide
vboxmanage storageattach $VM_NAME --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium $ISO_PATH
vboxmanage modifyvm $VM_NAME --ioapic on
vboxmanage modifyvm $VM_NAME --memory 1024 --vram 128
vboxmanage modifyvm $VM_NAME --nic1 nat
# vboxmanage modifyvm $VM_NAME --natpf1 "guestssh,tcp,,2222,,22"
vboxmanage modifyvm $VM_NAME --natdnshostresolver1 on
vboxmanage sharedfolder add $VM_NAME --name shared --hostpath $SHARED_PATH --automount

vboxmanage startvm $VM_NAME
