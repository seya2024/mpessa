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
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  String _selectedBank = 'Dashen Bank';
  String _searchQuery = '';
  bool _isLoading = false;
  
  // Complete List of Ethiopian Banks
  final List<String> _allBanks = [
    // Commercial Banks
    'Commercial Bank of Ethiopia (CBE)',
    'Dashen Bank',
    'Awash Bank',
    'Abyssinia Bank',
    'Hibret Bank',
    'Zemen Bank',
    'Oromia Bank (OB)',
    'Wegagen Bank',
    'Nib International Bank',
    'Berhan Bank',
    'Bunna Bank',
    'Debub Global Bank',
    'Enat Bank',
    'Addis International Bank',
    'ZamZam Bank',
    'HIJIRA Bank',
    'Gadaa Bank',
    'Tsehay Bank',
    'Amhara Bank',
    'Sidama Bank',
    'Shabelle Bank',
    'Rammis Bank',
    'Kifiya Financial Technology',
    'Ahadu Bank',
    'TsedaY Bank',

  
  ];

  // Get filtered banks based on search
  List<String> get _filteredBanks {
    if (_searchQuery.isEmpty) return _allBanks;
    return _allBanks.where((bank) =>
        bank.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send to Bank'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Bank', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            
            // Search Field
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  // Reset selected bank if current selection is not in filtered list
                  if (_filteredBanks.isNotEmpty && !_filteredBanks.contains(_selectedBank)) {
                    _selectedBank = _filteredBanks.first;
                  }
                });
              },
              decoration: InputDecoration(
                hintText: 'Search bank...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
            const SizedBox(height: 12),
            
            // Bank Dropdown - Fixed version
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _filteredBanks.contains(_selectedBank) ? _selectedBank : null,
                  isExpanded: true,
                  hint: Text(
                    _searchQuery.isEmpty ? 'Select a bank' : 'No matching banks found',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedBank = value;
                        _searchQuery = ''; // Clear search after selection
                      });
                    }
                  },
                  items: _filteredBanks.map((bank) {
                    return DropdownMenuItem<String>(
                      value: bank,
                      child: Text(
                        bank,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            const Text('Account Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            
            TextFormField(
              controller: _accountController,
              decoration: const InputDecoration(
                labelText: 'Bank Account Number',
                prefixIcon: Icon(Icons.numbers),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount (BIRR)',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Transfer Fee:', style: TextStyle(fontWeight: FontWeight.w500)),
                      const Text('15 BIRR', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Processing Time:', style: TextStyle(fontWeight: FontWeight.w500)),
                      Text('1-2 business days', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            const Text('Security', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            
            TextFormField(
              controller: _pinController,
              decoration: const InputDecoration(
                labelText: 'M-PESA PIN',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              obscureText: true,
              maxLength: 4,
            ),
            
            const SizedBox(height: 24),
            
            GreenButton(
              onPressed: _transferToBank,
              text: 'TRANSFER TO BANK',
              isLoading: _isLoading,
            ),
            
            const SizedBox(height: 16),
            
            // Info Note
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade700, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Transfer may take 1-2 business days to reflect in your bank account.',
                      style: TextStyle(fontSize: 11, color: Colors.blue.shade700),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _transferToBank() async {
    if (_accountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter bank account number'), backgroundColor: Colors.red),
      );
      return;
    }
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter amount'), backgroundColor: Colors.red),
      );
      return;
    }
    if (_pinController.text.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid PIN'), backgroundColor: Colors.red),
      );
      return;
    }
    
    if (!await context.read<SettingsProvider>().verifyPin(_pinController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid PIN'), backgroundColor: Colors.red),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    final amount = double.parse(_amountController.text);
    await Future.delayed(const Duration(seconds: 2));
    context.read<UserProvider>().updateBalance(amount + 15, true);
    
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Transfer Initiated'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bank: $_selectedBank'),
              const SizedBox(height: 4),
              Text('Account: ${_accountController.text}'),
              const SizedBox(height: 4),
              Text('Amount: ETB ${_amountController.text}'),
              const SizedBox(height: 4),
              Text('Fee: ETB 15'),
              const SizedBox(height: 8),
              const Divider(),
              Text('Total: ETB ${(amount + 15).toStringAsFixed(2)}'),
              const SizedBox(height: 8),
              Text('Reference: ${DateTime.now().millisecondsSinceEpoch}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
    setState(() => _isLoading = false);
  }
}