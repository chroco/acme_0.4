#!/bin/sh
# this is for automating the assignment
# tasks becausse i'm I don't want

printf "\nDemonstrating Unbind/Bind of the e1000e driver\n"
printf "\nls results:\n"
ls /sys/module/e1000e/drivers/pci\:e1000e/

printf "\nUnbinding the e1000e driver\n"
echo 0000:03:00.0 > /sys/module/e1000e/drivers/pci\:e1000e/unbind
printf "\nls results:\n"
ls /sys/module/e1000e/drivers/pci\:e1000e/

printf "\nBinding the e1000e driver\n"
echo 0000:03:00.0 > /sys/module/e1000e/drivers/pci\:e1000e/bind
printf "\nls results:\n"
ls /sys/module/e1000e/drivers/pci\:e1000e/

printf "\nUnbinding the e1000e driver so I can play with it\n"
echo 0000:03:00.0 > /sys/module/e1000e/drivers/pci\:e1000e/unbind
printf "\nls results:\n"
ls /sys/module/e1000e/drivers/pci\:e1000e/

printf "\nCompiling and insmoding acme_pci.ko\n"
make
insmod acme_pci.ko

printf "\nCompiling acme_pci_rwr\n"
gcc -o acme_pci_rwr acme_pci_rwr.c

printf "\ndmesg output:\n"
dmesg | tail

./acme_pci_rwr
printf "\nTurn on LED0\n"
./acme_pci_rwr 1
./acme_pci_rwr

printf "\nSleep for 2 seconds (using sleep 4 because sleep is off)\n"
sleep 4

printf "\nTurn off LED0\n"
./acme_pci_rwr 0

printf "\nrmoding acme_pci and cleaning up\n"
rmmod acme_pci
make clean
rm acme_pci_rwr

printf "\nBinding the e1000e driver\n"
echo 0000:03:00.0 > /sys/module/e1000e/drivers/pci\:e1000e/bind
printf "\nls results:\n"
ls /sys/module/e1000e/drivers/pci\:e1000e/

printf "\ndmesg output:\n"
dmesg | tail

