# Montage IA

Application mobile Flutter de montage vidéo automatique avec IA interne.

## Description

Cette application permet de monter automatiquement des vidéos et photos à partir d’un script utilisateur. Tout le traitement vidéo se fait via IA locale interne, sans serveur externe d’IA.

## Fonctionnalités

- Upload de vidéos/photos
- Saisie de script de montage
- Montage automatique via FFmpeg
- Export direct sur mobile
- Gestion freemium (2 vidéos/jour gratuites)

## Architecture

- **Frontend**: Flutter (iOS/Android)
- **Backend**: Node.js + TypeScript + BullMQ + FFmpeg
- **IA Locale**: FFmpeg pour montage vidéo

## Installation

### Backend

```bash
cd backend
npm install
npm run build
npm start
```

### Frontend

```bash
cd frontend
flutter pub get
flutter run
```

## Utilisation

1. Ouvrir l'app
2. Sélectionner fichiers
3. Coller script (ex: "photo1 -> fade -> photo2")
4. Monter vidéo
5. Télécharger

## Script Format

Exemples:
- "photo1 -> fade -> photo2 -> musique X"
- Transitions: fade, cut
- Effets: zoom, etc.
