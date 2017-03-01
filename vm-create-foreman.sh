# Change these variables as needed

VM_NAME="foreman"

ISO_PATH="${HOME}/Downloads/CentOS-7-x86_64-Minimal-1511.iso"

VBOX_HOME="${HOME}/VirtualBox VMs"

VM_HD1_PATH="${VBOX_HOME}/${VM_NAME}/sda.vdi" # The path to VM hard disk (to be created).
VM_HD2_PATH="${VBOX_HOME}/${VM_NAME}/sdb.vdi" # The path to VM hard disk (to be created).

SHARED_PATH=~ # Share home directory with the VM


vboxmanage createvm --name $VM_NAME --ostype "RedHat_64" --register
vboxmanage storagectl $VM_NAME --name "SATA Controller" --add sata --controller IntelAHCI
vboxmanage createhd --filename "$VM_HD1_PATH" --size 32768
vboxmanage createhd --filename "$VM_HD2_PATH" --size 200000000
vboxmanage storageattach $VM_NAME --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VM_HD1_PATH"
vboxmanage storageattach $VM_NAME --storagectl "SATA Controller" --port 0 --device 1 --type hdd --medium "$VM_HD2_PATH"
vboxmanage storagectl $VM_NAME --name "IDE Controller" --add ide
vboxmanage storageattach $VM_NAME --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium "$ISO_PATH"
vboxmanage modifyvm $VM_NAME --ioapic on
vboxmanage modifyvm $VM_NAME --memory 1024 --vram 128
vboxmanage modifyvm $VM_NAME --nic1 intnet
vboxmanage modifyvm $VM_NAME --nic2 nat
vboxmanage modifyvm $VM_NAME --natpf2 "guestssh,tcp,,2222,,22"
vboxmanage modifyvm $VM_NAME --natdnshostresolver1 on
vboxmanage sharedfolder add $VM_NAME --name shared --hostpath $SHARED_PATH --automount

vboxmanage startvm $VM_NAME
