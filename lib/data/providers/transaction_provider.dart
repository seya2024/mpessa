import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> _transactions = [];
  
  List<Transaction> get transactions => _transactions;
  List<Transaction> get recentTransactions => _transactions.take(5).toList();
  
  void loadTransactions() {
    _transactions = [
      Transaction(
        id: '1',
        type: TransactionType.sent,
        amount: 1500,
        recipientName: 'Bet-WIFI',
        recipientPhone: '1234567',
        description: 'Bet-WIFI bills',
        date: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Transaction(
        id: '2',
        type: TransactionType.sent,
        amount: 500,
        recipientName: 'BEU DELIVERY',
        recipientPhone: '9876543',
        description: 'Delivery service',
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Transaction(
        id: '3',
        type: TransactionType.received,
        amount: 2000,
        recipientName: 'Seid Mohammed',
        recipientPhone: '251777851925',
        senderName: 'Dammah',
        description: 'Payment received',
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
    notifyListeners();
  }
  
  Future<bool> sendMoney({
    required String recipientPhone,
    required double amount,
    required String pin,
    String? description,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final transaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: TransactionType.sent,
      amount: amount,
      recipientName: 'Recipient',
      recipientPhone: recipientPhone,
      description: description ?? 'Money transfer',
      date: DateTime.now(),
    );
    
    _transactions.insert(0, transaction);
    notifyListeners();
    return true;
  }
  
  Future<bool> buyAirtime({
    required String phoneNumber,
    required double amount,
    required String pin,
    String? packageDetails,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final transaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: TransactionType.airtime,
      amount: amount,
      recipientName: 'Self',
      recipientPhone: phoneNumber,
      description: packageDetails ?? 'Airtime purchase',
      date: DateTime.now(),
    );
    
    _transactions.insert(0, transaction);
    notifyListeners();
    return true;
  }
  
  Future<bool> payBill({
    required String billerName,
    required String accountNumber,
    required double amount,
    required String pin,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    final transaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: TransactionType.bill,
      amount: amount,
      recipientName: billerName,
      recipientPhone: accountNumber,
      description: 'Bill payment to $billerName',
      date: DateTime.now(),
    );
    
    _transactions.insert(0, transaction);
    notifyListeners();
    return true;
  }
}