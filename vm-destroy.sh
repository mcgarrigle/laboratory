#/bin/bash

vboxmanage controlvm $1 poweroff
sleep 5
vboxmanage unregistervm $1 --delete
