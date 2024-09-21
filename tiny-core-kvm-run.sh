#!/bin/bash

echo "Initializing Virtualization Setup"

# Check if the user provided a VM name argument
if [ -z "$1" ]; then
    echo "Usage: $0 <vm-name>"
    exit 1
fi

VM_NAME=$1


# Check if the CPU supports virtualization
VIRT_SUPPORT=$(egrep -c '(vmx|svm)' /proc/cpuinfo)

if [ "$VIRT_SUPPORT" -eq 0 ]; then
    echo "Virtualization is not supported on this CPU."
    exit 1
fi

echo "Virtualization is supported. Proceeding with setup..."

# Update the package list
sudo apt update


# Install necessary packages for KVM and virtualization management
sudo apt -y install virt-manager bridge-utils cpu-checker libvirt-clients libvirt-daemon-system qemu-system-x86 qemu-kvm


# Check KVM status
sudo kvm-ok

# Checking if we have our image, if not we are downloading it
cd /var/lib/libvirt/images/ || { echo "Failed to access /var/lib/libvirt/images/"; exit 1; }

TINY_CORE_ISO="Core-15.0.iso"
TINY_CORE_URL="http://www.tinycorelinux.net/15.x/x86/release/Core-15.0.iso"
TINY_CORE_DISK_IMAGE="${1}_tinycore-vm.qcow2"

# Check if the Tiny Core ISO already exists in the directory
if [ -f "$TINY_CORE_ISO" ]; then
    echo "$TINY_CORE_ISO already exists. No need to download."
else
    echo "Downloading Tiny Core Linux distro..." 
    wget $TINY_CORE_URL
fi


qemu-img create -f qcow2 /var/lib/libvirt/images/$TINY_CORE_DISK_IMAGE 2G

echo "Setup completed successfully."

# Running the system service
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

# Install the VM
virt-install \
--name "$VM_NAME" \
--memory 512 \
--vcpus 1 \
--disk /var/lib/libvirt/images/$TINY_CORE_DISK_IMAGE \
--cdrom /var/lib/libvirt/images/Core-15.0.iso \
--os-variant generic \
--network network=default \
--graphics none \
--console pty,target_type=serial \
--boot cdrom


