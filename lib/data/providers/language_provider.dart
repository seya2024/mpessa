import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'ENGLISH';
  
  String get currentLanguage => _currentLanguage;
  
  void setLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }
  
  String getWelcomeMessage() {
    switch (_currentLanguage) {
      case 'AFAN OROMOO':
        return 'Ashamta,';
      case 'አማርኛ':
        return 'ሰላም,';
      case 'SOMALI':
        return 'Salaan,';
      default:
        return 'Hello,';
    }
  }
  
  String getBalanceLabel() {
    switch (_currentLanguage) {
      case 'AFAN OROMOO':
        return 'M-PESA BALANCE';
      case 'አማርኛ':
        return 'M-PESA ቀሪ ሂሳብ';
      case 'SOMALI':
        return 'M-PESA BALANCE';
      default:
        return 'M-PESA BALANCE';
    }
  }
}