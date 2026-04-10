import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final SharedPreferences prefs;
  bool _isLoggedIn = false;
  String? _currentUserId;
  String? _currentPhoneNumber;
  
  AuthProvider(this.prefs) {
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _currentUserId = prefs.getString('userId');
    _currentPhoneNumber = prefs.getString('phoneNumber');
  }
  
  bool get isLoggedIn => _isLoggedIn;
  String? get currentUserId => _currentUserId;
  String? get currentPhoneNumber => _currentPhoneNumber;
  
  Future<bool> login(String phone, String pin) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (phone.isNotEmpty && pin.isNotEmpty) {
      _isLoggedIn = true;
      _currentUserId = 'user_${DateTime.now().millisecondsSinceEpoch}';
      _currentPhoneNumber = phone;
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userId', _currentUserId!);
      await prefs.setString('phoneNumber', phone);
      notifyListeners();
      return true;
    }
    return false;
  }
  
  Future<void> logout() async {
    _isLoggedIn = false;
    _currentUserId = null;
    _currentPhoneNumber = null;
    await prefs.remove('isLoggedIn');
    await prefs.remove('userId');
    await prefs.remove('phoneNumber');
    notifyListeners();
  }
}