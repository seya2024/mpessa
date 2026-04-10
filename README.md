## Getting Started

This project is a starting point for a Flutter application.
# 💚 M-PESA Ethiopia - Mobile Money Application

<div align="center">
  <img src="assets/icons/mpesa_logo.png" alt="M-PESA Logo" width="120"/>
  <br/>
  <strong>A complete mobile money solution inspired by M-PESA</strong>
  <br/>
  <p>Send money, pay bills, buy airtime, and more - all in one super app!</p>
  
  ![Flutter Version](https://img.shields.io/badge/Flutter-3.41.6-blue)
  ![Dart Version](https://img.shields.io/badge/Dart-3.11.4-blue)
  ![License](https://img.shields.io/badge/License-MIT-green)
  ![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS%20%7C%20Web-brightgreen)
</div>

---

## 📱 About The Project

M-PESA Ethiopia is a feature-rich mobile money application that allows users to perform various financial transactions directly from their mobile devices. Built with Flutter, this app provides a seamless and secure way to manage money, pay bills, purchase airtime, and much more.

### ✨ Key Features

- 🔐 **Secure Authentication** - Login with PIN protection
- 💸 **Send Money** - Transfer funds to any mobile number
- 📱 **Buy Airtime** - Purchase airtime and data bundles
- 🏦 **Pay Bills** - Pay utility bills (Electricity, Water, TV, etc.)
- 💳 **Send to Bank** - Transfer money to bank accounts
- 📊 **Transaction History** - View all your transactions
- 🌍 **Multi-Language Support** - English, Afan Oromo, Amharic, Somali
- 👁️ **Balance Privacy** - Hide/show balance with one tap
- 🎨 **Modern UI** - Clean and intuitive Material Design 3 interface

### 🚀 Upcoming Features

- QR Code Payments
- M-Shwari Savings & Loans
- Insurance Services
- Investment Options
- Mini Apps Integration
- Safari.com Travel Booking

---

## 📸 Screenshots

<div align="center">
  <table>
    <tr>
      <td><img src="screenshots/login.png" width="200" alt="Login Screen"/></td>
      <td><img src="screenshots/pin.png" width="200" alt="PIN Screen"/></td>
      <td><img src="screenshots/home.png" width="200" alt="Home Screen"/></td>
    </tr>
    <tr>
      <td align="center">Login Screen</td>
      <td align="center">PIN Entry</td>
      <td align="center">Dashboard</td>
    </tr>
    <tr>
      <td><img src="screenshots/send_money.png" width="200" alt="Send Money"/></td>
      <td><img src="screenshots/transactions.png" width="200" alt="Transactions"/></td>
      <td><img src="screenshots/airtime.png" width="200" alt="Buy Airtime"/></td>
    </tr>
    <tr>
      <td align="center">Send Money</td>
      <td align="center">Transactions</td>
      <td align="center">Buy Airtime</td>
    </tr>
  </table>
</div>

---

## 🛠️ Tech Stack

- **Framework**: Flutter 3.41.6
- **Language**: Dart 3.11.4
- **State Management**: Provider + Riverpod
- **Navigation**: GoRouter
- **Local Storage**: SharedPreferences + Hive
- **Networking**: Dio + Retrofit
- **UI**: Material Design 3 + Google Fonts

---

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.41.6 or higher)
- [Dart SDK](https://dart.dev/get-dart) (3.11.4 or higher)
- [Android Studio](https://developer.android.com/studio) / [VS Code](https://code.visualstudio.com/)
- [Git](https://git-scm.com/)

---

## 🚀 Installation

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/mpesa-ethiopia.git
cd mpesa-ethiopia


3. Run code generation (if using Retrofit)
bash

-- flutter pub run build_runner build --delete-conflicting-outputs


4. Run the app
bash

# For Android
flutter run

# For iOS (Mac only)
flutter run -d ios

# For Web
flutter run -d chrome



🔧 Configuration
Environment Setup

Create a .env file in the project root:
env

API_BASE_URL=http://localhost:3000/api
API_TIMEOUT=30000

Test Credentials

Use these credentials for testing:
text

Phone Number: 251777851925
PIN: 0000

📁 Project Structure
text

lib/
├── core/
│   ├── constants/          # App constants and colors
│   ├── themes/             # Theme configuration
│   ├── utils/              # Utility functions
│   └── widgets/            # Reusable widgets
├── data/
│   ├── models/             # Data models
│   ├── providers/          # State management
│   └── services/           # API services
└── presentation/
    ├── screens/            # UI screens
    │   ├── auth/           # Authentication screens
    │   ├── home/           # Home screen
    │   ├── payments/       # Payment screens
    │   └── services/       # Service screens
    └── navigation/         # Route configuration

🧪 Testing

Run tests to ensure everything works correctly:
bash

# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

📦 Building APK
Debug APK
bash

flutter build apk --debug

Release APK
bash

flutter build apk --release

App Bundle
bash

flutter build appbundle

The output will be in build/app/outputs/ directory.
🌐 API Integration

This app can be integrated with a backend API. Sample API endpoints:
Endpoint	Method	Description
/api/auth/login	POST	User authentication
/api/auth/register	POST	User registration
/api/transactions/send	POST	Send money
/api/transactions/airtime	POST	Buy airtime
/api/transactions/bill	POST	Pay bill
/api/users/{id}/balance	GET	Get user balance
Mock API Setup
bash

# Install JSON Server
npm install -g json-server

# Run mock API
json-server --watch db.json --port 3000

🤝 Contributing

Contributions are welcome! Please follow these steps:

    Fork the Project

    Create your Feature Branch (git checkout -b feature/AmazingFeature)

    Commit your Changes (git commit -m 'Add some AmazingFeature')

    Push to the Branch (git push origin feature/AmazingFeature)

    Open a Pull Request

Guidelines

    Follow Flutter best practices

    Write meaningful commit messages

    Update documentation as needed

    Add tests for new features

📄 License

Distributed under the MIT License. See LICENSE file for more information.
👥 Authors

    Seid Seid - Initial Work - YourGitHub

🙏 Acknowledgments

    Flutter Team for the amazing framework

    Safaricom for inspiration

    All contributors and testers

📞 Contact & Support

    Email: support@mpesa.com

    Customer Care: +251 777 851 925

    Website: www.safaricom.et

⭐ Show Your Support

If you found this project helpful, please give it a ⭐ on GitHub!
<div align="center"> Made with ❤️ using Flutter </div> ```
Additional Files to Add
1. LICENSE (MIT License)
markdown

MIT License

Copyright (c) 2024 Seid Seid

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

2. .gitignore
gitignore

# Flutter/Dart
.dart_tool/
.packages/
pubspec.lock
build/
flutter_*.png
*.iml
*.iws
.idea/
.vscode/
*.swp
*.lock
*.log

# Android
*.class
*.log
*.iml
*.iws
.idea/
local.properties
*.pyc
*.pyo
*.dll
*.exe
*.apk
*.aab

# iOS
*.mode1v3
*.mode2v3
*.moved-aside
*.pbxuser
*.perspectivev3
*.pyc
*.xcuserstate
xcuserdata/
Pods/
Podfile.lock
*.app

# Web
.dccache/
*.dll
*.exe
*.pdb

# Environment
.env
*.env.local
*.key

# Logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# OS
.DS_Store
Thumbs.db

3. CODE_OF_CONDUCT.md
markdown

# Contributor Covenant Code of Conduct

## Our Pledge

We as members, contributors, and leaders pledge to make participation in our
community a harassment-free experience for everyone.

## Our Standards

Examples of behavior that contributes to a positive environment:

- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Accepting constructive criticism

## Enforcement

Instances of abusive, harassing, or otherwise unacceptable behavior may be
reported to the project team. All complaints will be reviewed and investigated.

## Attribution

This Code of Conduct is adapted from the [Contributor Covenant][homepage].

[homepage]: https://www.contributor-covenant.org

4. CONTRIBUTING.md
markdown

# Contributing to M-PESA Ethiopia

We love your input! We want to make contributing as easy and transparent as possible.

## Development Process

1. Fork the repo and create your branch from `main`
2. Make your changes
3. Test your changes
4. Create a pull request

## Pull Request Process

1. Update the README.md with details of changes if needed
2. Update the pubspec.yaml version if applicable
3. The PR will be merged once reviewed

## Any contributions you make will be under the MIT Software License

When you submit code changes, your submissions are understood to be under the same [MIT License](LICENSE) that covers the project.

5. SECURITY.md
markdown

# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Reporting a Vulnerability

Please report security vulnerabilities by emailing security@mpesa.com

- Do not disclose vulnerabilities publicly
- Include as much information as possible
- We will respond within 48 hours

How to Push to GitHub
bash

# Initialize git repository
git init

# Add all files
git add .

# Commit changes
git commit -m "Initial commit: M-PESA Ethiopia mobile money app"

# Add remote repository
git remote add origin https://github.com/yourusername/mpesa-ethiopia.git

# Push to GitHub
git branch -M main
git push -u origin main

This README provides a complete, professional documentation for your M-PESA Ethiopia project on GitHub!




