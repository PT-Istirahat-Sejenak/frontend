# Donora

<div align="center">
  <img src="https://pub-edaa30c44dd54bf0a8c76f650df4e4dd.r2.dev/profiles/1747421635_logo.png" alt="Donora Logo" width="200"/>
  <p><em>Donora</em></p>
</div>

## 🩸 Overview

Donora is an app that connects blood donors and those in need of blood to help solve the blood shortage probleminIndonesia.
Donora encourages people to donate blood to meet the blood supply needs in Indonesia.

### ✨ Key Features

- **🧩 Authentication**: Provide a secure login and registration system to verify and protect user identity.
- **💬 Chat between Donors and
Donor Seekers**: Real-time chat feature that allows donor seekers to communicate directly with blood donors
- **🔎 Blood Donor Request Form**: A form that allows users to submit specific blood donor requests based on blood type.
- **📲 Blood Donor Need Notification**: Provide quick notification to users regarding blood donation needs
- **🤖 Dora AI Chatbot**: Dora AI chatbot utilizes the Gemini API to quickly and accurately answer users questions regarding blood donation.

## 🛠️ Tech Stack

- **Framework**: [Flutter 3.29.2](https://flutter.dev/)
- **Design Systems**: [Materia](https://m3.material.io/get-started)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Database**: PostgreSQL
- **Object Storage**: R2 Cloudflare
- **AI Integration**: Google GeminiAI chatbot
- **Notification**: Firebase Cloud Messaging
- **Chat**: WebSocket

## 🚀 Getting Started

### 📋 Prerequisites

- Flutter SDK 3.7.2
- Android Studio or Android Command-line tools if developing not in apple environment
- Emulator Android or physical devices
- Firebase CLI

### 🛠 Installation

1. Clone the repository:
   ```bash
    git clone https://github.com/
    PT-Istirahat-Sejenak/frontend.git
    cd frontend
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app on an emulator or device:
   ```bash
   flutter run
   ```

## 📂 Project Structure
```

DONORA_DEV\LIB
├───core
├───models
├───providers
├───routes
├───screens
│   ├───auth
│   │   ├───donor
│   │   ├───password
│   │   └───seeker
│   ├───chat
│   ├───chatbot
│   ├───donor
│   ├───education
│   ├───onboarding
│   ├───role
│   ├───seeker
│   └───splash
├───services
├───utils
└───widgets

```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
