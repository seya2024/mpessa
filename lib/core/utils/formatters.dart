import 'package:intl/intl.dart';

class AppFormatters {
  static String formatCurrency(double amount) {
    final format = NumberFormat.currency(
      locale: 'en_US',
      symbol: 'ETB', // Changed from '\$' to 'ETB'
      decimalDigits: 2,
    );
    return format.format(amount);
  }
  
  static String formatNumber(double amount) {
    final format = NumberFormat('#,##0.00', 'en_US');
    return format.format(amount);
  }
}