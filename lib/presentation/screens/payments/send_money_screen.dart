import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/green_button.dart';
import '../../../core/widgets/copyright_footer.dart';
import '../../../core/constants/colors.dart';
import '../../../data/providers/user_provider.dart';
import '../../../data/providers/transaction_provider.dart';
import '../../../data/providers/settings_provider.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().currentUser;
    
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _recipientController,
                      decoration: const InputDecoration(labelText: 'Recipient Phone Number', prefixIcon: Icon(Icons.person)),
                      keyboardType: TextInputType.phone,
                      validator: (v) => (v == null || v.isEmpty) ? 'Enter recipient number' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(labelText: 'Amount (BIRR)', prefixIcon: Icon(Icons.attach_money)),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Enter amount';
                        final amount = double.tryParse(v);
                        if (amount == null || amount <= 0) return 'Invalid amount';
                        if (user != null && amount > user.balance) return 'Insufficient balance';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _pinController,
                      decoration: const InputDecoration(labelText: 'M-PESA PIN', prefixIcon: Icon(Icons.lock)),
                      obscureText: true,
                      maxLength: 4,
                      validator: (v) => (v == null || v.length != 4) ? 'Enter 4-digit PIN' : null,
                    ),
                    const SizedBox(height: 24),
                    GreenButton(
                      onPressed: _sendMoney,
                      text: 'SEND MONEY',
                      isLoading: _isLoading,
                    ),
                  ],
                ),
              ),
            ),
            const CopyrightFooter(),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMoney() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      if (!await context.read<SettingsProvider>().verifyPin(_pinController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid PIN'), backgroundColor: Colors.red));
        setState(() => _isLoading = false);
        return;
      }
      
      final amount = double.parse(_amountController.text);
      final success = await context.read<TransactionProvider>().sendMoney(
        recipientPhone: _recipientController.text,
        amount: amount,
        pin: _pinController.text,
      );
      
      if (success) {
        context.read<UserProvider>().updateBalance(amount, true);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Money sent!'), backgroundColor: Colors.green));
        Navigator.pop(context);
      }
      setState(() => _isLoading = false);
    }
  }
}