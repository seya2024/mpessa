import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';
import '../payments/send_money_screen.dart';
import '../payments/pay_with_mpesa_screen.dart';
import '../payments/pay_bill_screen.dart';
import '../payments/buy_airtime_screen.dart';
import 'send_to_bank_screen.dart';

class MpesaServicesScreen extends StatelessWidget {
  const MpesaServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('M-PESA Services')),
      body: ListView(
        children: [
          _serviceTile(Icons.send, 'Send Money', 'Transfer money', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SendMoneyScreen()))),
          _serviceTile(Icons.payment, 'Pay Bill', 'Pay utility bills', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PayBillScreen()))),
          _serviceTile(Icons.sim_card, 'Buy Airtime', 'Purchase airtime', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BuyAirtimeScreen()))),
          _serviceTile(Icons.account_balance, 'Send to Bank', 'Transfer to bank', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SendToBankScreen()))),
          _serviceTile(Icons.qr_code_scanner, 'Scan QR', 'Pay by QR code', () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Coming soon!')))),
        ],
      ),
    );
  }
  
  Widget _serviceTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: AppColors.primary)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}