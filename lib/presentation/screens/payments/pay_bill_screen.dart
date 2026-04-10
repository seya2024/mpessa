import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/green_button.dart';
import '../../../core/constants/colors.dart';
import '../../../data/providers/user_provider.dart';
import '../../../data/providers/transaction_provider.dart';
import '../../../data/providers/settings_provider.dart';

class PayBillScreen extends StatefulWidget {
  final String? billerName;
  const PayBillScreen({super.key, this.billerName});

  @override
  State<PayBillScreen> createState() => _PayBillScreenState();
}

class _PayBillScreenState extends State<PayBillScreen> {
  String? _selectedBiller;
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  bool _isLoading = false;
  
  final List<Map<String, dynamic>> _billers = [
    {'name': 'Ethio Telecom', 'icon': Icons.phone_android},
    {'name': 'EEU Electricity', 'icon': Icons.bolt},
    {'name': 'Water Supply', 'icon': Icons.water_drop},
    {'name': 'DStv', 'icon': Icons.tv},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.billerName != null) _selectedBiller = widget.billerName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Bill')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Select Biller', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedBiller,
                  isExpanded: true,
                  hint: const Text('Choose a biller'),
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                  onChanged: (value) => setState(() => _selectedBiller = value),
                  items: _billers.map((biller) {
                    return DropdownMenuItem<String>(
                      value: biller['name'] as String,
                      child: Row(
                        children: [
                          Icon(biller['icon'] as IconData, size: 20, color: AppColors.primary),
                          const SizedBox(width: 10),
                          Text(biller['name'] as String),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _accountController,
              decoration: const InputDecoration(labelText: 'Account Number', prefixIcon: Icon(Icons.numbers)),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount (BIRR)', prefixIcon: Icon(Icons.attach_money)),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _pinController,
              decoration: const InputDecoration(labelText: 'M-PESA PIN', prefixIcon: Icon(Icons.lock)),
              obscureText: true,
              maxLength: 4,
            ),
            const SizedBox(height: 24),
            GreenButton(
              onPressed: _payBill,
              text: 'PAY BILL',
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _payBill() async {
    if (_selectedBiller == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a biller'), backgroundColor: Colors.red));
      return;
    }
    if (_accountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter account number'), backgroundColor: Colors.red));
      return;
    }
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter amount'), backgroundColor: Colors.red));
      return;
    }
    if (_pinController.text.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter valid PIN'), backgroundColor: Colors.red));
      return;
    }
    
    if (!await context.read<SettingsProvider>().verifyPin(_pinController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid PIN'), backgroundColor: Colors.red));
      return;
    }
    
    setState(() => _isLoading = true);
    final amount = double.parse(_amountController.text);
    await context.read<TransactionProvider>().payBill(
      billerName: _selectedBiller!,
      accountNumber: _accountController.text,
      amount: amount,
      pin: _pinController.text,
    );
    context.read<UserProvider>().updateBalance(amount, true);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bill paid successfully!'), backgroundColor: Colors.green));
    Navigator.pop(context);
    setState(() => _isLoading = false);
  }
}