# LumiDistro - Custom Linux Distribution

Une distribution Linux ultra-légère et moderne créée de A à Z.

## Spécifications
- **RAM**: 256MB minimum
- **Stockage**: 2GB minimum
- **CPU**: Architecture x86_64
- **Interface**: Moderne et épurée

## Architecture
- Base: Debian Minimal
- Window Manager: Sway (Wayland)
- Theme: Custom GTK/Qt theme
- Applications: Essentielles ultra-légères

## 🚀 Démarrage rapide

### Sur Windows (Options)

**Option 1: GitHub Actions (Recommandé - Pas de stockage local)**
1. Créez un compte GitHub gratuit
2. Uploadez le projet sur GitHub
3. Lancez le workflow "Build ISO"
4. Téléchargez l'ISO (~15-30 min)
5. Voir **LOW-STORAGE-GUIDE.md**

**Option 2: Docker (Plus léger que WSL)**
1. Installez Docker Desktop: https://www.docker.com/products/docker-desktop/
2. Exécutez: `.\docker-build.ps1`
3. L'ISO sera créée automatiquement

**Option 3: WSL**
1. Lisez **WINDOWS-GUIDE.md**
2. Exécutez: `.\windows-build.ps1` (PowerShell administrateur)

**Option 4: Sans installation (Live USB ou VM)**
1. Lisez **NO-WSL-GUIDE.md**
2. Utilisez VirtualBox ou un Live USB

### Sur Linux
```bash
./create-iso.sh
```

## 📖 Documentation
- **LOW-STORAGE-GUIDE.md** - Guide pour PC avec peu de stockage (GitHub Actions)
- **NO-WSL-GUIDE.md** - Guide SANS WSL (Docker, Live USB, VM)
- **WINDOWS-GUIDE.md** - Guide Windows avec WSL
- **GUIDE.md** - Guide détaillé du projet
- **INSTALL.md** - Instructions d'installation

## Installation
Flasher l'ISO sur USB (Rufus sur Windows, dd sur Linux) et booter.
