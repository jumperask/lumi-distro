#!/bin/bash
# LumiDistro Build Script

set -e

DISTRO_NAME="lumi-distro"
VERSION="1.0"
BUILD_DIR="build"
CHROOT_DIR="$BUILD_DIR/chroot"
ISO_DIR="$BUILD_DIR/iso"

echo "=== Building $DISTRO_NAME v$VERSION ==="

# Nettoyage
rm -rf $BUILD_DIR
mkdir -p $CHROOT_DIR $ISO_DIR

# Installation de debootstrap si nécessaire
if ! command -v debootstrap &> /dev/null; then
    echo "Installation de debootstrap..."
    sudo apt-get update
    sudo apt-get install -y debootstrap
fi

# Création du système de base Debian
echo "Création du système de base..."
sudo debootstrap --arch=amd64 bookworm $CHROOT_DIR http://deb.debian.org/debian

# Configuration de base
echo "Configuration du système..."
sudo cp files/sources.list $CHROOT_DIR/etc/apt/sources.list
sudo cp files/hostname $CHROOT_DIR/etc/hostname
sudo cp files/hosts $CHROOT_DIR/etc/hosts

# Montage des filesystems nécessaires
sudo mount --bind /dev $CHROOT_DIR/dev
sudo mount --bind /dev/pts $CHROOT_DIR/dev/pts
sudo mount --bind /proc $CHROOT_DIR/proc
sudo mount --bind /sys $CHROOT_DIR/sys

# Installation des paquets
echo "Installation des paquets..."
sudo chroot $CHROOT_DIR /bin/bash -c "
    apt-get update
    apt-get install -y $(cat packages.txt)
    apt-get clean
"

# Configuration de l'utilisateur
echo "Configuration de l'utilisateur..."
sudo chroot $CHROOT_DIR /bin/bash -c "
    useradd -m -s /bin/bash lumi
    echo 'lumi:lumi' | chpasswd
    usermod -aG sudo,audio,video lumi
"

# Copie des fichiers de configuration
echo "Copie des configurations..."
sudo cp -r files/home/. $CHROOT_DIR/home/lumi/
sudo chown -R lumi:lumi $CHROOT_DIR/home/lumi

# Configuration de Sway
sudo cp files/sway/config $CHROOT_DIR/home/lumi/.config/sway/config
sudo chown -R lumi:lumi $CHROOT_DIR/home/lumi/.config

# Démontage
sudo umount $CHROOT_DIR/dev/pts
sudo umount $CHROOT_DIR/dev
sudo umount $CHROOT_DIR/proc
sudo umount $CHROOT_DIR/sys

# Création de l'ISO
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

echo "=== Build terminé ==="
echo "ISO créée: $DISTRO_NAME-$VERSION.iso"
