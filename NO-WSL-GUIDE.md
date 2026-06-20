# Construire LumiDistro SANS WSL

Vous ne voulez pas installer WSL sur votre PC principal? Voici les alternatives:

## Option 1: Machine Virtuelle (Recommandée)

### VirtualBox (Gratuit)
1. Téléchargez VirtualBox: https://www.virtualbox.org/
2. Téléchargez Debian ISO: https://www.debian.org/distrib/
3. Créez une VM Debian (4GB RAM, 20GB disque)
4. Installez Debian dans la VM
5. Copiez le dossier `lumi-distro` dans la VM
6. Exécutez: `sudo ./create-iso.sh`
7. Copiez l'ISO vers Windows via partage de fichiers

### VMware Workstation Player (Gratuit pour usage personnel)
1. Téléchargez VMware Player: https://www.vmware.com/products/workstation-player.html
2. Procédez comme pour VirtualBox

## Option 2: Live USB Temporaire

1. Téléchargez Ubuntu Live USB: https://ubuntu.com/download/desktop
2. Flash sur USB avec Rufus
3. Boot sur l'USB (sans installer)
4. Ouvrez un terminal
5. Montez votre partition Windows:
```bash
sudo mkdir /mnt/windows
sudo mount -t ntfs-3g /dev/sdX1 /mnt/windows
```
6. Accédez au projet:
```bash
cd /mnt/windows/Users/l4r/Documents/lumiweb/lumi-distro
```
7. Construisez l'ISO:
```bash
sudo ./create-iso.sh
```
8. L'ISO sera créée directement sur Windows

## Option 3: Docker (Plus léger que WSL)

1. Installez Docker Desktop: https://www.docker.com/products/docker-desktop/
2. Créez un Dockerfile pour le build

Je vais créer un Dockerfile pour vous.

## Option 4: Service en ligne

Utilisez GitHub Actions ou un service de CI/CD pour construire l'ISO automatiquement.

## Option 5: Utiliser votre 2ème PC

Si votre 2ème PC a déjà un OS:
1. Installez Linux temporairement
2. Construisez l'ISO
3. Réinstallez LumiDistro

## Recommandation

**Option 1 (VirtualBox)** est la plus simple:
- Pas d'installation permanente sur Windows
- Environnement Linux complet
- Facile à supprimer après usage
- Partage de fichiers simple avec Windows

## Option 2 (Live USB)** si vous préférez:
- Aucune installation
- Boot temporaire
- Accès direct aux fichiers Windows

Quelle option préférez-vous? Je peux créer les fichiers nécessaires pour l'option choisie.
