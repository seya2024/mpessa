import 'package:flutter/material.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _currentUser;
  
  User? get currentUser => _currentUser;
  
  void loadUser() {
    _currentUser = User(
      id: '1',
      fullName: 'Seid Mohammed',
      phoneNumber: '251777851925',
      email: 'seid@mpesa.com',
      balance: 15250.50,
    );
    notifyListeners();
  }
  
  void updateBalance(double amount, bool isAddition) {
    if (_currentUser != null) {
      if (isAddition) {
        _currentUser!.balance += amount;
      } else {
        _currentUser!.balance -= amount;
      }
      notifyListeners();
    }
  }
  
  void addMoney(double amount) {
    if (_currentUser != null) {
      _currentUser!.balance += amount;
      notifyListeners();
    }
  }
}