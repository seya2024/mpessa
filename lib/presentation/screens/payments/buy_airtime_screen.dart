import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/green_button.dart';
import '../../../core/constants/colors.dart';
import '../../../data/providers/user_provider.dart';
import '../../../data/providers/transaction_provider.dart';
import '../../../data/providers/settings_provider.dart';

class BuyAirtimeScreen extends StatefulWidget {
  const BuyAirtimeScreen({super.key});

  @override
  State<BuyAirtimeScreen> createState() => _BuyAirtimeScreenState();
}

class _BuyAirtimeScreenState extends State<BuyAirtimeScreen> {
  String _selectedPhone = 'My Number';
  final _otherPhoneController = TextEditingController();
  double _selectedAmount = 50;
  String _selectedPin = '';
  bool _isLoading = false;
  final List<double> _amounts = [10, 25, 50, 100, 200, 500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buy Airtime')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Phone Number', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: RadioListTile(title: const Text('My Number'), value: 'My Number', groupValue: _selectedPhone, onChanged: (v) => setState(() => _selectedPhone = v!), activeColor: AppColors.primary, contentPadding: EdgeInsets.zero)),
                Expanded(child: RadioListTile(title: const Text('Other Number'), value: 'Other Number', groupValue: _selectedPhone, onChanged: (v) => setState(() => _selectedPhone = v!), activeColor: AppColors.primary, contentPadding: EdgeInsets.zero)),
              ],
            ),
            if (_selectedPhone == 'Other Number') ...[
              const SizedBox(height: 8),
              TextField(controller: _otherPhoneController, decoration: const InputDecoration(labelText: 'Phone Number', prefixIcon: Icon(Icons.phone)), keyboardType: TextInputType.phone),
            ],
            const SizedBox(height: 20),
            const Text('Select Amount', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(spacing: 10, runSpacing: 10, children: _amounts.map((amount) => FilterChip(label: Text('$amount BIRR'), selected: _selectedAmount == amount, onSelected: (_) => setState(() => _selectedAmount = amount), selectedColor: AppColors.primary, labelStyle: TextStyle(color: _selectedAmount == amount ? Colors.white : Colors.black))).toList()),
            const SizedBox(height: 24),
            Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)), child: Column(children: [
              _detailRow('Amount:', '$_selectedAmount BIRR'),
              _detailRow('Data:', _getData(_selectedAmount)),
              _detailRow('Voice:', _getVoice(_selectedAmount)),
              _detailRow('Validity:', _getValidity(_selectedAmount)),
            ])),
            const SizedBox(height: 24),
            const Text('Enter M-PESA PIN', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(onChanged: (v) => _selectedPin = v, decoration: const InputDecoration(labelText: 'PIN', prefixIcon: Icon(Icons.lock)), obscureText: true, maxLength: 4),
            const SizedBox(height: 24),
            GreenButton(onPressed: _buyAirtime, text: 'BUY AIRTIME', isLoading: _isLoading),
          ],
        ),
      ),
    );
  }
  
  Widget _detailRow(String label, String value) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label), Text(value, style: const TextStyle(fontWeight: FontWeight.w500))]));
  String _getData(double a) { switch (a) { case 10: return '100MB'; case 25: return '500MB'; case 50: return '1GB'; case 100: return '3GB'; case 200: return '8GB'; case 500: return '25GB'; default: return '1GB'; } }
  String _getVoice(double a) { switch (a) { case 10: return '10 min'; case 25: return '30 min'; case 50: return '60 min'; case 100: return '200 min'; case 200: return '500 min'; case 500: return '1500 min'; default: return '60 min'; } }
  String _getValidity(double a) { switch (a) { case 10: return '1 day'; case 25: return '3 days'; case 50: return '7 days'; default: return '30 days'; } }
  
  Future<void> _buyAirtime() async {
    if (_selectedPin.length != 4) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter valid PIN'), backgroundColor: Colors.red)); return; }
    if (!await context.read<SettingsProvider>().verifyPin(_selectedPin)) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid PIN'), backgroundColor: Colors.red)); return; }
    
    setState(() => _isLoading = true);
    final phone = _selectedPhone == 'My Number' ? context.read<UserProvider>().currentUser?.phoneNumber ?? '' : _otherPhoneController.text;
    await context.read<TransactionProvider>().buyAirtime(phoneNumber: phone, amount: _selectedAmount, pin: _selectedPin);
    context.read<UserProvider>().updateBalance(_selectedAmount, true);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Airtime purchased!'), backgroundColor: Colors.green));
    Navigator.pop(context);
    setState(() => _isLoading = false);
  }
}