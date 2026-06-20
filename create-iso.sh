#!/bin/bash
# LumiDistro ISO Creation Script

set -e

DISTRO_NAME="lumi-distro"
VERSION="1.0"
BUILD_DIR="build"
CHROOT_DIR="$BUILD_DIR/chroot"
ISO_DIR="$BUILD_DIR/iso"

echo "=== Création ISO $DISTRO_NAME v$VERSION ==="

# Nettoyage
rm -rf $BUILD_DIR
mkdir -p $CHROOT_DIR $ISO_DIR

# Installation des dépendances
echo "Installation des dépendances..."
sudo apt-get update
sudo apt-get install -y debootstrap xorriso grub-pc-bin grub-efi-amd64-bin mtools

# Création du système de base
echo "Création du système de base Debian..."
sudo debootstrap --arch=amd64 bookworm $CHROOT_DIR http://deb.debian.org/debian

# Configuration système
echo "Configuration du système..."
sudo cp files/sources.list $CHROOT_DIR/etc/apt/sources.list
sudo cp files/hostname $CHROOT_DIR/etc/hostname
sudo cp files/hosts $CHROOT_DIR/etc/hosts

# Montage des filesystems
sudo mount --bind /dev $CHROOT_DIR/dev
sudo mount --bind /dev/pts $CHROOT_DIR/dev/pts
sudo mount --bind /proc $CHROOT_DIR/proc
sudo mount --bind /sys $CHROOT_DIR/sys

# Installation des paquets
echo "Installation des paquets..."
sudo chroot $CHROOT_DIR /bin/bash -c "
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y $(cat packages.txt)
    apt-get clean
"

# Configuration utilisateur
echo "Configuration utilisateur..."
sudo chroot $CHROOT_DIR /bin/bash -c "
    useradd -m -s /bin/bash lumi
    echo 'lumi:lumi' | chpasswd
    usermod -aG sudo,audio,video,lumi lumi
"

# Copie des configurations
echo "Copie des configurations..."
sudo cp -r files/home/. $CHROOT_DIR/home/lumi/
sudo chown -R lumi:lumi $CHROOT_DIR/home/lumi

# Configuration GRUB
echo "Configuration GRUB..."
sudo chroot $CHROOT_DIR /bin/bash -c "
    grub-install --target=i386-pc /dev/sda
    update-grub
"

# Optimisation
echo "Optimisation du système..."
sudo cp optimize.sh $CHROOT_DIR/tmp/
sudo chroot $CHROOT_DIR /bin/bash -c "chmod +x /tmp/optimize.sh && /tmp/optimize.sh"

# Démontage
sudo umount $CHROOT_DIR/dev/pts
sudo umount $CHROOT_DIR/dev
sudo umount $CHROOT_DIR/proc
sudo umount $CHROOT_DIR/sys

# Création ISO
echo "Création de l'ISO..."
cd $BUILD_DIR
sudo xorriso -as mkisofs \
    -r -V "$DISTRO_NAME" \
    -o ../$DISTRO_NAME-$VERSION.iso \
    -b isolinux/isolinux.bin \
    -c isolinux/boot.cat \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    iso/

cd ..

echo "=== ISO créée: $DISTRO_NAME-$VERSION.iso ==="
echo "Taille: $(du -h $DISTRO_NAME-$VERSION.iso | cut -f1)"
