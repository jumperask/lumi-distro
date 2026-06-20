# LumiDistro - Votre Distribution Linux Personnalisée

## 🎯 Présentation

LumiDistro est une distribution Linux ultra-légère et moderne conçue pour les ordinateurs avec des ressources limitées. Elle offre une interface épurée et performante.

## 📋 Spécifications Techniques

### Configuration minimale requise
- **RAM**: 256MB (512MB recommandé)
- **Stockage**: 2GB (8GB recommandé)
- **CPU**: x86_64
- **Graphique**: Compatible Wayland

### Architecture
- **Base**: Debian 12 (Bookworm)
- **Window Manager**: Sway (Wayland)
- **Barre de tâches**: Waybar
- **Launcher**: Rofi
- **Thème**: Personnalisé sombre/épuré

## 🗂️ Structure du Projet

```
lumi-distro/
├── README.md                 # Présentation du projet
├── INSTALL.md                # Guide d'installation détaillé
├── GUIDE.md                  # Ce fichier
├── build.sh                  # Script de construction principal
├── create-iso.sh            # Script de création ISO
├── optimize.sh              # Script d'optimisation système
├── generate-wallpaper.py    # Générateur de wallpaper
├── packages.txt             # Liste des paquets à installer
└── files/                   # Fichiers de configuration
    ├── sources.list         # Sources Debian
    ├── hostname             # Nom de la machine
    ├── hosts                # Fichier hosts
    ├── isolinux/            # Configuration de boot
    │   └── isolinux.cfg     # Menu de démarrage
    └── home/                # Configuration utilisateur
        └── .config/
            ├── sway/        # Configuration Sway
            │   ├── config   # Config principale
            │   └── autostart.sh
            ├── waybar/      # Configuration Waybar
            │   ├── config
            │   └── style.css
            ├── rofi/        # Configuration Rofi
            │   └── lumi.rasi
            ├── gtk-3.0/     # Configuration GTK
            │   └── settings.ini
            └── wallpaper.png
```

## 🚀 Construction de l'ISO

### Étape 1: Prérequis
```bash
sudo apt-get update
sudo apt-get install -y debootstrap xorriso grub-pc-bin grub-efi-amd64-bin mtools python3-pip
pip3 install Pillow
```

### Étape 2: Préparation
```bash
cd lumi-distro
chmod +x *.sh *.py
```

### Étape 3: Génération du wallpaper (optionnel)
```bash
python3 generate-wallpaper.py
```

### Étape 4: Construction de l'ISO
```bash
sudo ./create-iso.sh
```

L'ISO sera créée: `lumi-distro-1.0.iso`

## 💾 Installation sur USB

### Sur Linux
```bash
sudo dd if=lumi-distro-1.0.iso of=/dev/sdX bs=4M status=progress
sync
```

### Sur Windows
Utiliser Rufus ou balenaEtcher avec l'ISO.

## 🖥️ Utilisation

### Premier démarrage
1. Boot depuis l'USB
2. Sélectionner "Lancer LumiDistro"
3. Connexion: utilisateur `lumi`, mot de passe `lumi`

### Raccourcis clavier principaux
- `Mod (Win) + Enter`: Terminal
- `Mod + D`: Menu d'applications
- `Mod + Shift + Q`: Fermer fenêtre
- `Mod + H/J/K/L`: Navigation fenêtres
- `Mod + 1-9`: Changer workspace
- `Mod + F`: Plein écran

## ⚙️ Personnalisation

### Modifier le thème
- Waybar: `files/home/.config/waybar/style.css`
- Rofi: `files/home/.config/rofi/lumi.rasi`
- Sway: `files/home/.config/sway/config`

### Ajouter des paquets
Modifier `packages.txt` et reconstruire l'ISO.

### Changer le wallpaper
Remplacer `files/home/.config/wallpaper.png` par votre image.

## 🔧 Optimisations incluses

- **ZRAM**: Compression de la RAM
- **TLP**: Gestion de l'énergie
- **Preload**: Préchargement des applications
- **Nettoyage automatique**: Journal et cache
- **Système de fichiers**: tmpfs pour /tmp et /var/tmp

## 📦 Paquets inclus

### Système de base
- Linux kernel, GRUB, sudo, network-manager

### Interface graphique
- Sway, Waybar, Rofi, Alacritty

### Applications
- Firefox, PCManFM, Geany, MPV
- Blueman, Pavucontrol

### Utilitaires
- htop, neofetch, git, vim

## 🎨 Design

### Palette de couleurs
- **Fond**: #1e1e2e (sombre)
- **Texte**: #cdd6f4 (clair)
- **Accent**: #89b4fa (bleu)
- **Urgent**: #f38ba8 (rose)

### Philosophie
- Minimaliste et épuré
- Performance avant tout
- Personnalisable
- Moderne et élégant

## 🛠️ Dépannage

### L'ISO ne boot pas
- Vérifier que l'USB est bien flashé
- Essayer en mode legacy BIOS
- Tester sur une autre machine

### Problèmes graphiques
- Boot en mode "nomodeset"
- Vérifier la compatibilité Wayland
- Installer les pilotes propriétaires si nécessaire

### Performance insuffisante
- Activer ZRAM: inclus dans optimize.sh
- Désactiver les effets visuels
- Utiliser des applications plus légères

## 📝 Notes importantes

- Changer le mot de passe par défaut après installation
- Sauvegarder vos données avant installation
- Tester en live USB avant installation complète
- Contribuer et personnaliser selon vos besoins

## 🎯 Prochaines améliorations possibles

- Ajout d'un installateur graphique
- Support multilingue complet
- Repository de paquets personnalisé
- Outil de configuration graphique
- Thèmes supplémentaires

## 📧 Support

Pour des questions ou contributions, consultez le fichier INSTALL.md.

---

**LumiDistro v1.0** - Créé avec ❤️ pour les PC avec ressources limitées
