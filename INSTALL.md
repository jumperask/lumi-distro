# Guide d'installation LumiDistro

## Prérequis

Pour construire LumiDistro, vous avez besoin de:
- Une machine Linux (Debian/Ubuntu recommandé)
- Au moins 10GB d'espace disque libre
- 4GB de RAM minimum
- Droits sudo

## Installation des dépendances

```bash
sudo apt-get update
sudo apt-get install -y debootstrap xorriso grub-pc-bin grub-efi-amd64-bin mtools
```

## Construction de l'ISO

1. Cloner ou télécharger le projet:
```bash
cd lumi-distro
```

2. Rendre les scripts exécutables:
```bash
chmod +x build.sh create-iso.sh optimize.sh generate-wallpaper.py
```

3. Générer le wallpaper (optionnel):
```bash
python3 generate-wallpaper.py
```

4. Construire l'ISO:
```bash
sudo ./create-iso.sh
```

L'ISO sera créée dans le répertoire parent: `lumi-distro-1.0.iso`

## Installation sur USB

Utiliser Rufus (Windows) ou dd (Linux):
```bash
sudo dd if=lumi-distro-1.0.iso of=/dev/sdX bs=4M status=progress
```

## Boot et installation

1. Boot depuis l'USB
2. Sélectionner "Lancer LumiDistro"
3. Une fois démarré, utiliser l'installateur pour installer sur le disque dur

## Configuration après installation

- Mot de passe par défaut: `lumi` / `lumi`
- Changer le mot de passe immédiatement: `passwd`
- Configurer le réseau via Network Manager
- Personnaliser les fichiers dans `~/.config`

## Spécifications minimales

- **RAM**: 256MB minimum (512MB recommandé)
- **Stockage**: 2GB minimum (8GB recommandé)
- **CPU**: x86_64
- **Graphique**: Compatible Wayland

## Raccourcis clavier Sway

- `Mod + Enter`: Ouvrir terminal
- `Mod + D`: Menu d'applications
- `Mod + Shift + Q`: Fermer fenêtre
- `Mod + H/J/K/L`: Navigation
- `Mod + 1-9`: Changer workspace
- `Mod + Shift + 1-9`: Déplacer fenêtre vers workspace
- `Mod + F`: Plein écran
- `Mod + Shift + E`: Quitter

## Support

Pour plus d'informations, voir le README.md
