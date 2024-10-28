<div align="center">

# 🌟 GoatrikHub

[![Flutter Version](https://img.shields.io/badge/flutter-v3.24.0-blue.svg)](https://flutter.dev)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
![Build Status](https://img.shields.io/github/workflow/status/yourusername/goatrik_hub/CI)
[![codecov](https://codecov.io/gh/yourusername/goatrik_hub/branch/main/graph/badge.svg)](https://codecov.io/gh/yourusername/goatrik_hub)

<p align="center">
  <img src="https://avatars.githubusercontent.com/u/45371611?s=400&u=649e5605dd55524840f3e44762b8bf190117909c&v=4" alt="GoatrikHub Logo" width="200"/>
</p>

### 🚀 Ett modernt och skalbart Flutter-projekt med fokus på användarupplevelse och säkerhet

[Funktioner](#-funktioner) •
[Kom igång](#-kom-igång) •
[Arkitektur](#-arkitektur) •
[Bidra](#-bidra) •
[Dokumentation](#-dokumentation)

---

<p align="center">
  <img src="assets/images/login_page.png" width="200" alt="Screenshot 1"/>
  &nbsp;&nbsp;&nbsp;&nbsp;

</p>

</div>

## ✨ Funktioner

### 🔐 Avancerad Autentisering & Behörighet
- Multi-nivå rollsystem (User, Admin, SuperAdmin)
- JWT-baserad autentisering
- Säker sessionshantering
- OAuth 2.0 integration

### 🎨 Modern UI/UX
- Material Design 3 med dynamiska färgteman
- Mörkt/ljust läge
- Responsiv design för alla skärmstorlekar
- Anpassningsbara widgets

### 🏗 Robust Arkitektur
- Clean Architecture principer
- Provider för state management
- Dependency Injection
- Modulariserad kodstruktur

### 🔄 Backend Integration
- RESTful API integration
- Effektiv felhantering
- Automatisk token refresh
- Offline-stöd

### 📊 Admin Dashboard
- Användarhantering
- Rollhantering
- Systemövervakning
- Analytics och rapporter

## 🚀 Kom igång

### Förutsättningar

- Flutter SDK (>=3.24.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Git

### Installation

1. Klona repot
```bash
git clone https://github.com/GoatrikWorks/goatrik_hub.git
```

2. Installera beroenden
```bash
cd goatrik_hub
flutter pub get
```

3. Konfigurera miljövariabler
```bash
cp .env.example .env.development
```

4. Kör appen
```bash
flutter run
```

<details>
<summary><b>📱 Plattformsspecifika inställningar</b></summary>

## Android
### Lägg till följande i android/app/build.gradle:
```gradle
android {
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```

## iOS
### Uppdatera ios/Runner/Info.plist
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access for profile photos</string>
```
</details>

## 🏗 Arkitektur
```
lib/
├── core/
│   ├── config/
│   ├── network/
│   ├── theme/
│   └── utils/
├── features/
│   ├── auth/
│   ├── home/
│   └── admin/
└── main.dart
```

## Arkitekturella Principer
<details>
<summary>Clean Architecture</summary>

```mermaid
graph TD
    A[UI Layer] --> B[Domain Layer]
    B --> C[Data Layer]
    C --> D[External Services]
```

</details>
<details>
<summary>State Management</summary>
Provider för enkel state management, Freezed för immutable models, och Repository pattern för datahämtning.
</details>

## 🔧 Konfiguration
### Miljövariabler
```env
API_URL=http://localhost:3000
CONNECT_TIMEOUT=5000
RECEIVE_TIMEOUT=3000
```

---

Supported Platforms  
| Platform | Status       |
|----------|--------------|
| Android  | ✅ Supported |
| iOS      | ✅ Supported |
| Web      | 🚧 In progress |
| Windows  | 🚧 In progress |
| macOS    | 🚧 In progress |
| Linux    | 🚧 In progress |
