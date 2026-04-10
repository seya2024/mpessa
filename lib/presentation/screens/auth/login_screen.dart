import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/green_button.dart';
import '../../../core/widgets/copyright_footer.dart';
import '../../../core/constants/colors.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/providers/language_provider.dart';
import 'pin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _selectedLanguage = 'ENGLISH';
  final List<String> languages = ['ENGLISH', 'AFAN OROMOO', 'አማርኛ', 'SOMALI'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary.withOpacity(0.1), Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildLanguageSelector(),
                const SizedBox(height: 20),
                _buildLogo(),
                const SizedBox(height: 20),
                const Text('m-pesa', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)),
                const Text('Safaricom', style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 40),
                const Text('WELCOME', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 28),
                _buildPhoneForm(),
                const SizedBox(height: 30),
                _buildFooterLinks(),
                const CopyrightFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildLanguageSelector() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: languages.map((lang) {
          return Flexible(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedLanguage = lang);
                context.read<LanguageProvider>().setLanguage(lang);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  color: _selectedLanguage == lang ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  lang,
                  style: TextStyle(
                    color: _selectedLanguage == lang ? Colors.white : Colors.grey.shade600,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildLogo() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 20)],
      ),
      child: const Icon(Icons.phone_android, size: 40, color: Colors.white),
    );
  }
  
  Widget _buildPhoneForm() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'ENTER PHONE NUMBER',
                  hintText: '+251 777 851 925',
                  prefixIcon: Icon(Icons.phone, color: AppColors.primary),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => (value == null || value.isEmpty) ? 'Please enter phone number' : null,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'PLEASE ENTER A VALID PHONE NUMBER\nYOU CAN EDIT THE NUMBER TO SWITCH ACCOUNT',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            const SizedBox(height: 28),
            GreenButton(
              onPressed: _handleContinue,
              text: 'CONTINUE →',
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFooterLinks() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _footerLink('CALL US', () => _showDialog('Call Us', 'Customer Care: +251 777 851 925\nAvailable 24/7')),
          Container(width: 1, height: 14, color: Colors.grey.shade300, margin: const EdgeInsets.symmetric(horizontal: 12)),
          _footerLink('TERMS', () => _showDialog('Terms and Conditions', '1. Terms and conditions text here...\n2. More terms...')),
          Container(width: 1, height: 14, color: Colors.grey.shade300, margin: const EdgeInsets.symmetric(horizontal: 12)),
          _footerLink('WEBSITE', () => _showDialog('Website', 'Visit: www.safaricom.et')),
        ],
      ),
    );
  }
  
  Widget _footerLink(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(text, style: const TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w500)),
    );
  }
  
  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }
  
  Future<void> _handleContinue() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => PinScreen(phoneNumber: _phoneController.text),
        ));
      }
      setState(() => _isLoading = false);
    }
  }
  
  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}