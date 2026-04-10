import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/green_button.dart';
import '../../../core/widgets/copyright_footer.dart';
import '../../../data/providers/user_provider.dart';
import '../../../data/providers/settings_provider.dart';

class PayWithMpesaScreen extends StatefulWidget {
  const PayWithMpesaScreen({super.key});

  @override
  State<PayWithMpesaScreen> createState() => _PayWithMpesaScreenState();
}

class _PayWithMpesaScreenState extends State<PayWithMpesaScreen> {
  final _merchantController = TextEditingController();
  final _amountController = TextEditingController();
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay with M-PESA')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _merchantController,
                decoration: const InputDecoration(labelText: 'Merchant Code', prefixIcon: Icon(Icons.store)),
                validator: (v) => (v == null || v.isEmpty) ? 'Enter merchant code' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount (BIRR)', prefixIcon: Icon(Icons.attach_money)),
                keyboardType: TextInputType.number,
                validator: (v) => (v == null || v.isEmpty) ? 'Enter amount' : null,
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
                onPressed: _pay,
                text: 'PAY NOW',
                isLoading: _isLoading,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CopyrightFooter(),
    );
  }

  Future<void> _pay() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      if (!await context.read<SettingsProvider>().verifyPin(_pinController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid PIN'), backgroundColor: Colors.red));
        setState(() => _isLoading = false);
        return;
      }
      
      await Future.delayed(const Duration(seconds: 1));
      context.read<UserProvider>().updateBalance(double.parse(_amountController.text), true);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment successful!'), backgroundColor: Colors.green));
      Navigator.pop(context);
      setState(() => _isLoading = false);
    }
  }
}