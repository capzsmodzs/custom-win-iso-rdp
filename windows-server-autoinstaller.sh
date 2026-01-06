#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server or Windows version:"
    echo "1. Windows Server 2012"
    echo "2. Windows Server 2019"
    echo "3. Windows Server 2022"
    echo "4. Windows 10"
    echo "5. Windows 11"
    echo "6. Windows 1021h2"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Windows Server 2012
        img_file="windows2012.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195443&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2012.iso"
        ;;
    2)
        # Windows Server 2019
        img_file="windows2019.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2019.iso"
        ;;
    3)
        # Windows Server 2022
        img_file="windows2022.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2022.iso"
        ;;
    4)
        # Windows 10
        img_file="windows10.img"
        iso_link="https://software.download.prss.microsoft.com/dbazure/Win10_22H2_English_x64v1.iso?t=119be422-476e-4f38-969a-ecd1f5e56df9&P1=1767770558&P2=601&P3=2&P4=TCnnCEm64QT9DCDeVG0xlFWaVolAoXOCh1q6o40Xm8gA8cN0a7tgIZS0G7J2MyrEF3%2bstns%2bymzaEX7dqy9eBfNooV9kNv2q9b70zNOmZILpF%2bNixmz8iEVZbgHMwPj13wZFGYCe7RagncsfGnp3vwlYOpAXiI%2beHAGmNfOJLG6%2bGLTObJs0qceC8sVpENw%2bbWVw0K3uIN3WHdD7Eab8kME9MJDhtSm9pvZ6N3Tv4u9UJ5N%2bwVGlVcBKATMJFrC03JHCmImbE1YY%2bir%2fX%2fqfSCUCAGcXBfZg%2fAr5h43FedaUmTcwosYrkfv3eLS%2bm1sbiOKRcjQLK4d8T7GbLZPUgA%3d%3d"
        iso_file="windows10.iso"
        ;;
    5)
        # Windows 11
        img_file="windows11.img"
        iso_link="http://152.53.194.161/WIN11.ISO"
        iso_file="windows11.iso"
        ;;
    6)
        # Windows 1021h2
        img_file="windows1021h2.img"
        iso_link="http://152.53.194.161/win1021H2.img"
        iso_file="windows1021h2.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 40G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO
wget -O virtio-win.iso 'http://143.198.80.134/virtio-win.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
