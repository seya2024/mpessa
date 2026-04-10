import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class SettingsProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  bool _isBalanceHidden = false;
  String _mpesaPin = AppConstants.defaultPin;
  
  SettingsProvider(this.prefs) {
    _isBalanceHidden = prefs.getBool('isBalanceHidden') ?? false;
    _mpesaPin = prefs.getString('mpesaPin') ?? AppConstants.defaultPin;
  }
  
  bool get isBalanceHidden => _isBalanceHidden;
  String get mpesaPin => _mpesaPin;
  
  void toggleBalanceVisibility() {
    _isBalanceHidden = !_isBalanceHidden;
    prefs.setBool('isBalanceHidden', _isBalanceHidden);
    notifyListeners();
  }
  
  Future<bool> verifyPin(String pin) async {
    return pin == _mpesaPin;
  }
  
  Future<bool> changePin(String oldPin, String newPin) async {
    if (oldPin == _mpesaPin && newPin.length == AppConstants.pinLength) {
      _mpesaPin = newPin;
      await prefs.setString('mpesaPin', newPin);
      notifyListeners();
      return true;
    }
    return false;
  }
  
  Future<void> resetPin(String phoneNumber) async {
    _mpesaPin = AppConstants.defaultPin;
    await prefs.setString('mpesaPin', AppConstants.defaultPin);
    notifyListeners();
  }
}