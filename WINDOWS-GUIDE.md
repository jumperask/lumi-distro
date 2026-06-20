# Guide Windows - LumiDistro

## 🪟 Installation sur Windows

Puisque vous êtes sur Windows, vous devez utiliser **WSL2** (Windows Subsystem for Linux) pour construire LumiDistro.

## Étape 1: Activer WSL2

### Option A: Via PowerShell (Administrateur)
```powershell
wsl --install
```
Redémarrez votre ordinateur après l'installation.

### Option B: Manuellement
1. Ouvrir "Activer ou désactiver des fonctionnalités Windows"
2. Activer "Sous-système Linux pour Windows"
3. Activer "Plateforme de machine virtuelle"
4. Redémarrer

## Étape 2: Installer Ubuntu dans WSL

```powershell
wsl --install -d Ubuntu
```
Suivez les instructions pour créer un utilisateur UNIX.

## Étape 3: Préparer l'environnement

Ouvrez Ubuntu (WSL) et exécutez:

```bash
# Mettre à jour le système
sudo apt update && sudo apt upgrade -y

# Installer les dépendances
sudo apt install -y debootstrap xorriso grub-pc-bin grub-efi-amd64-bin mtools python3 python3-pip

# Installer Pillow pour le wallpaper
pip3 install Pillow
```

## Étape 4: Accéder au projet Windows depuis WSL

```bash
# Accéder au lecteur C
cd /mnt/c/Users/l4r/Documents/lumiweb/lumi-distro

# Vérifier les fichiers
ls -la
```

## Étape 5: Construire l'ISO

```bash
# Rendre les scripts exécutables
chmod +x *.sh *.py

# Générer le wallpaper (optionnel)
python3 generate-wallpaper.py

# Construire l'ISO
sudo ./create-iso.sh
```

## Étape 6: Récupérer l'ISO sur Windows

L'ISO sera créée dans: `/mnt/c/Users/l4r/Documents/lumiweb/lumi-distro-1.0.iso`

Vous pouvez l'utiliser directement depuis Windows!

## 🔧 Alternative: Script PowerShell automatisé

J'ai créé un script PowerShell pour automatiser tout le processus.

### Utilisation du script PowerShell

1. Ouvrez PowerShell en tant qu'administrateur
2. Exécutez:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
cd C:\Users\l4r\Documents\lumiweb\lumi-distro
.\windows-build.ps1
```

Le script va:
- Vérifier/installer WSL2
- Installer Ubuntu
- Configurer l'environnement
- Construire l'ISO automatiquement

## 📦 Flasher l'ISO sur USB depuis Windows

### Option A: Rufus (Recommandé)
1. Téléchargez Rufus: https://rufus.ie/
2. Sélectionnez votre USB
3. Choisissez l'ISO `lumi-distro-1.0.iso`
4. Cliquez sur "Démarrer"

### Option B: balenaEtcher
1. Téléchargez balenaEtcher: https://etcher.balena.io/
2. Sélectionnez l'ISO
3. Sélectionnez votre USB
4. Flash!

## ⚠️ Dépannage Windows

### WSL ne s'installe pas
- Vérifiez que virtualisation est activée dans le BIOS
- Assurez-vous que Windows est à jour
- Essayez: `wsl --update`

### Problèmes de permissions
```bash
# Dans WSL, corriger les permissions
sudo chmod +x *.sh *.py
```

### Accès aux fichiers Windows
```bash
# Les fichiers Windows sont dans /mnt/c/
cd /mnt/c/Users/votre_nom/...
```

### WSL lent
- Activer WSL2 au lieu de WSL1
- Placer le projet dans le système de fichiers WSL (pas dans /mnt/c/)
- Utiliser SSD pour WSL

## 🎯 Résumé rapide

1. **Activer WSL2**: `wsl --install`
2. **Installer Ubuntu**: `wsl --install -d Ubuntu`
3. **Dans WSL**: `cd /mnt/c/Users/l4r/Documents/lumiweb/lumi-distro`
4. **Construire**: `sudo ./create-iso.sh`
5. **Récupérer**: L'ISO est dans le même dossier sur Windows

## 📞 Support

Si vous rencontrez des problèmes:
- Vérifiez que WSL2 est bien installé: `wsl --status`
- Testez WSL: `wsl echo "WSL fonctionne"`
- Consultez le GUIDE.md pour plus de détails

---

**Note**: La construction peut prendre 15-30 minutes selon votre machine.
