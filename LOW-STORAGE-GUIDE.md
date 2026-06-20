# Construire LumiDisto avec peu de stockage

Votre PC principal n'a pas assez de stockage? Voici les solutions:

## Option 1: GitHub Actions (Recommandé - GRATUIT)

Construire l'ISO automatiquement dans le cloud sans stockage local.

### Étapes:

1. **Créez un compte GitHub** (gratuit): https://github.com/signup

2. **Créez un nouveau repository**
   - Cliquez sur "New repository"
   - Nom: `lumi-distro`
   - Rendez-le public
   - Cliquez sur "Create repository"

3. **Uploadez les fichiers**
   - Cliquez sur "uploading an existing file"
   - Glissez-déposez tous les fichiers du dossier `lumi-distro`
   - Cliquez sur "Commit changes"

4. **Créez le workflow GitHub Actions**
   - Créez le dossier `.github/workflows/`
   - Ajoutez le fichier `build-iso.yml` (je vais le créer pour vous)

5. **Lancez le build**
   - Allez dans l'onglet "Actions"
   - Sélectionnez "Build ISO"
   - Cliquez sur "Run workflow"
   - Attendez (~15-30 minutes)

6. **Téléchargez l'ISO**
   - Une fois terminé, cliquez sur le build
   - Téléchargez l'artifact `lumi-distro-1.0.iso`

## Option 2: Utiliser un disque externe

Si vous avez un disque dur externe:
1. Connectez le disque externe
2. Utilisez l'option Live USB (voir NO-WSL-GUIDE.md)
3. Spécifiez le disque externe pour le build

## Option 3: Build directement sur le 2ème PC

Si votre 2ème PC peut booter:
1. Téléchargez Ubuntu sur le 2ème PC
2. Boot en mode live
3. Construisez l'ISO directement
4. Flash sur USB

## Option 4: Service de build en ligne

Utilisez des services comme:
- **GitLab CI** (gratuit)
- **CircleCI** (gratuit pour petits projets)
- **Travis CI** (gratuit pour open source)

## Recommandation

**GitHub Actions** est la meilleure option car:
- 100% gratuit
- Pas de stockage local nécessaire
- Automatique
- Téléchargement direct de l'ISO
- Pas besoin de configuration complexe

Je vais créer le fichier GitHub Actions pour vous.
