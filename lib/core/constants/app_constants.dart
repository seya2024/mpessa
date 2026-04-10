class AppConstants {
  static const String appName = 'M-PESA Ethiopia';
  static const String version = '1.0.0';
  static const String companyName = 'Safaricom Telecommunications Ethiopia PLC';
  
  // Transaction limits
  static const double minTransactionAmount = 10.0;
  static const double maxTransactionAmount = 150000.0;
  static const double dailyLimit = 300000.0;
  static const double transferFee = 15.0;
  
  // PIN
  static const int pinLength = 4;
  static const String defaultPin = '0000';
  
  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration splashDelay = Duration(seconds: 2);
}

class RouteNames {
  static const String login = '/';
  static const String pin = '/pin';
  static const String home = '/home';
  static const String sendMoney = '/send-money';
  static const String payWithMpesa = '/pay-with-mpesa';
  static const String payBill = '/pay-bill';
  static const String buyAirtime = '/buy-airtime';
  static const String buyPackages = '/buy-packages';
  static const String sendToBank = '/send-to-bank';
  static const String mpesaServices = '/mpesa-services';
  static const String safari = '/safari';
  static const String miniApps = '/mini-apps';
}