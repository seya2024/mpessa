import 'package:intl/intl.dart';

class CurrencyHelper {
  static const String symbol = 'ETB'; // or 'Birr'
  static const String code = 'ETB';
  
  static String format(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return '${formatter.format(amount)} $symbol';
  }
  
  static String formatWithoutSymbol(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(amount);
  }
}