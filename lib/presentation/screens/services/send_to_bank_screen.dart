import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/green_button.dart';
import '../../../core/constants/colors.dart';
import '../../../data/providers/user_provider.dart';
import '../../../data/providers/settings_provider.dart';

class SendToBankScreen extends StatefulWidget {
  const SendToBankScreen({super.key});

  @override
  State<SendToBankScreen> createState() => _SendToBankScreenState();
}

class _SendToBankScreenState extends State<SendToBankScreen> {
  final _accountController = TextEditingController();
  final _amountController = TextEditingController();
  final _pinController = TextEditingController();
  String _selectedBank = 'Dashen Bank';
  bool _isLoading = false;
  final List<String> _banks = ['Dashen Bank', 'Commercial Bank of Ethiopia', 'Awash Bank', 'Abyssinia Bank'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send to Bank')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Select Bank', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedBank,
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                  onChanged: (v) => setState(() => _selectedBank = v!),
                  items: _banks.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(controller: _accountController, decoration: const InputDecoration(labelText: 'Bank Account Number', prefixIcon: Icon(Icons.numbers))),
            const SizedBox(height: 16),
            TextFormField(controller: _amountController, decoration: const InputDecoration(labelText: 'Amount (BIRR)', prefixIcon: Icon(Icons.attach_money)), keyboardType: TextInputType.number),
            const SizedBox(height: 16),
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)), child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Transfer Fee:'), Text('15 BIRR', style: TextStyle(color: Colors.red))])),
            const SizedBox(height: 16),
            TextFormField(controller: _pinController, decoration: const InputDecoration(labelText: 'M-PESA PIN', prefixIcon: Icon(Icons.lock)), obscureText: true, maxLength: 4),
            const SizedBox(height: 24),
            GreenButton(onPressed: _transfer, text: 'TRANSFER TO BANK', isLoading: _isLoading),
          ],
        ),
      ),
    );
  }

  Future<void> _transfer() async {
    if (_accountController.text.isEmpty || _amountController.text.isEmpty || _pinController.text.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fill all fields'), backgroundColor: Colors.red));
      return;
    }
    if (!await context.read<SettingsProvider>().verifyPin(_pinController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid PIN'), backgroundColor: Colors.red));
      return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    context.read<UserProvider>().updateBalance(double.parse(_amountController.text) + 15, true);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Transfer initiated!'), backgroundColor: Colors.green));
    Navigator.pop(context);
    setState(() => _isLoading = false);
  }
}