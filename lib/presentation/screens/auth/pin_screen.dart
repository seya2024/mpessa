import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/green_button.dart';
import '../../../core/widgets/copyright_footer.dart';
import '../../../core/constants/colors.dart';
import '../../../data/providers/auth_provider.dart';
import '../../../data/providers/settings_provider.dart';
import '../../../data/providers/language_provider.dart';
import '../home/home_screen.dart';

class PinScreen extends StatefulWidget {
  final String phoneNumber;
  const PinScreen({super.key, required this.phoneNumber});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  String _pin = '';
  bool _isLoading = false;
  final List<String> _languages = ['ENGLISH', 'AFAN OROMOO', 'አማርኛ', 'SOMALI'];
  String _selectedLanguage = 'ENGLISH';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildLanguageSelector(),
            _buildUserInfo(),
            _buildActionButtons(),
            const SizedBox(height: 20),
            const Text('ENTER M-PESA PIN:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            _buildPinDots(),
            const SizedBox(height: 10),
            _buildOptionsRow(),
            const Spacer(),
            _buildPinPad(),
            const CopyrightFooter(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLanguageSelector() {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _languages.map((lang) {
          return Flexible(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedLanguage = lang);
                context.read<LanguageProvider>().setLanguage(lang);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: _selectedLanguage == lang ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(lang, style: TextStyle(
                  color: _selectedLanguage == lang ? Colors.white : Colors.grey.shade600,
                  fontSize: 9,
                )),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  
  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          const CircleAvatar(radius: 28, backgroundColor: AppColors.primary, child: Icon(Icons.person, size: 32, color: Colors.white)),
          const SizedBox(height: 6),
          const Text('SEID SEID', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 2),
          Text(widget.phoneNumber, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
  
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          _actionButton('Scan QR', Icons.qr_code_scanner),
          const SizedBox(width: 8),
          _actionButton('Pay', Icons.payment),
          const SizedBox(width: 8),
          _actionButton('Airtime', Icons.sim_card),
        ],
      ),
    );
  }
  
  Widget _actionButton(String label, IconData icon) {
    return Expanded(
      child: GestureDetector(
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$label coming soon!'))),
        child: Container(
          height: 45,
          decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primary, size: 18),
              const SizedBox(height: 2),
              Text(label, style: const TextStyle(fontSize: 9)),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildPinDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          width: 14, height: 14,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _pin.length > index ? AppColors.primary : Colors.grey.shade300,
          ),
        );
      }),
    );
  }
  
  Widget _buildOptionsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(onPressed: () {}, child: const Text('CHANGE PIN', style: TextStyle(color: AppColors.primary, fontSize: 10))),
        Container(width: 1, height: 12, color: Colors.grey.shade300, margin: const EdgeInsets.symmetric(horizontal: 6)),
        TextButton(onPressed: () {}, child: const Text('FORGOT PIN?', style: TextStyle(color: AppColors.primary, fontSize: 10))),
      ],
    );
  }
  
  Widget _buildPinPad() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 8)],
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_pinButton('1'), _pinButton('2'), _pinButton('3')]),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_pinButton('4'), _pinButton('5'), _pinButton('6')]),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_pinButton('7'), _pinButton('8'), _pinButton('9')]),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_pinButton('', isDelete: true), _pinButton('0'), _pinButton('', isConfirm: true)]),
        ],
      ),
    );
  }
  
  Widget _pinButton(String number, {bool isDelete = false, bool isConfirm = false}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (isDelete) {
            if (_pin.isNotEmpty) setState(() => _pin = _pin.substring(0, _pin.length - 1));
          } else if (isConfirm) {
            _verifyPin();
          } else {
            if (_pin.length < 4) {
              setState(() => _pin += number);
              if (_pin.length == 4) _verifyPin();
            }
          }
        },
        child: Container(
          height: 48,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: isDelete || isConfirm ? Colors.grey.shade50 : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isDelete || isConfirm ? [] : [BoxShadow(color: Colors.grey.shade200, blurRadius: 4)],
          ),
          child: Center(
            child: isDelete ? const Icon(Icons.backspace_outlined, size: 20)
                : isConfirm ? const Icon(Icons.check_circle, color: AppColors.primary, size: 24)
                : Text(number, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
  
  Future<void> _verifyPin() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (await context.read<SettingsProvider>().verifyPin(_pin)) {
      final success = await context.read<AuthProvider>().login(widget.phoneNumber, _pin);
      if (success && mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      }
    } else {
      setState(() { _pin = ''; _isLoading = false; });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid PIN'), backgroundColor: Colors.red));
    }
  }
}