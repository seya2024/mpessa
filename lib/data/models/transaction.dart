enum TransactionType { sent, received, bill, airtime, bankTransfer }

class Transaction {
  final String id;
  final TransactionType type;
  final double amount;
  final String recipientName;
  final String recipientPhone;
  final String? senderName;
  final String? senderPhone;
  final String description;
  final DateTime date;
  final String status;
  
  Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.recipientName,
    required this.recipientPhone,
    this.senderName,
    this.senderPhone,
    required this.description,
    required this.date,
    this.status = 'Completed',
  });
}