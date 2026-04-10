import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../core/widgets/copyright_footer.dart';
import '../../../core/constants/colors.dart';
import '../../../data/providers/user_provider.dart';
import '../../../data/providers/transaction_provider.dart';
import '../../../data/providers/settings_provider.dart';
import '../../../data/providers/language_provider.dart';
import '../payments/send_money_screen.dart';
import '../payments/pay_with_mpesa_screen.dart';
import '../services/buy_packages_screen.dart';
import '../services/send_to_bank_screen.dart';
import '../services/mpesa_services_screen.dart';
import '../extras/safari_screen.dart';
import '../extras/mini_apps_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const HomeContent(),
    const MpesaServicesScreen(),
    const SafariScreen(),
    const MiniAppsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.phone_android_outlined), label: 'M-PESA'),
          BottomNavigationBarItem(icon: Icon(Icons.public_outlined), label: 'SAFARI.COM'),
          BottomNavigationBarItem(icon: Icon(Icons.apps_outlined), label: 'MINI APPS'),
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUser();
      context.read<TransactionProvider>().loadTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().currentUser;
    final transactions = context.watch<TransactionProvider>().recentTransactions;
    final settings = context.watch<SettingsProvider>();
    final language = context.watch<LanguageProvider>();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(language.getWelcomeMessage(), style: const TextStyle(fontSize: 12)),
            Text(user?.fullName ?? 'Seid!', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {})],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            _buildBalanceCard(user, settings, language),
            const SizedBox(height: 18),
            _buildQuickActions(),
            const SizedBox(height: 18),
            _buildRewardCard(),
            const SizedBox(height: 20),
            const Text('SUGGESTED FOR YOU', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildSuggestions(),
            const SizedBox(height: 20),
            const Text('FREQUENTS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildFrequentContact(),
            const CopyrightFooter(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBalanceCard(user, SettingsProvider settings, LanguageProvider language) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryDark]),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(language.getBalanceLabel(), style: const TextStyle(color: Colors.white70, fontSize: 11)),
              GestureDetector(
                onTap: () => settings.toggleBalanceVisibility(),
                child: Icon(settings.isBalanceHidden ? Icons.visibility_off : Icons.visibility, color: Colors.white70, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 6),
          if (settings.isBalanceHidden)
            const Text('••••••', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold))
          else
            Text('${NumberFormat('#,##0.00').format(user?.balance ?? 0)} Birr', 
                style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => _addMoney(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
              child: const Text('+ ADD MONEY', style: TextStyle(color: Colors.white, fontSize: 11)),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuickActions() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.85,
      children: [
        _actionItem(Icons.send, 'Send Money', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SendMoneyScreen()))),
        _actionItem(Icons.payment, 'Pay with M-PESA', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PayWithMpesaScreen()))),
        _actionItem(Icons.shopping_bag, 'Buy Packages', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BuyPackagesScreen()))),
        _actionItem(Icons.account_balance, 'Send to Bank', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SendToBankScreen()))),
      ],
    );
  }
  
  Widget _actionItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 8)]),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 10), textAlign: TextAlign.center),
        ],
      ),
    );
  }
  
  Widget _buildRewardCard() {
    return GestureDetector(
      onTap: () => _showDialog('Reward Account', 'Points: 2,000\n20 BIRR Cashback - 500 pts\n50 BIRR Voucher - 1,000 pts'),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.card_giftcard, color: AppColors.primary, size: 22)),
                const SizedBox(width: 10),
                const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Reward Account', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  Text('20.00 Birr', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                ]),
              ],
            ),
            Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: const Text('EXPLORE', style: TextStyle(color: AppColors.primary, fontSize: 11))),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSuggestions() {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _suggestionCard('Bet-WIFI bills', 'buy your', AppColors.primary),
          const SizedBox(width: 10),
          _suggestionCard('mPesa', 'bet-wifi bills', Colors.orange),
          const SizedBox(width: 10),
          _suggestionCard('BEU DELIVERY', 'Delivery', Colors.blue),
        ],
      ),
    );
  }
  
  Widget _suggestionCard(String title, String subtitle, Color color) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.wifi, color: color, size: 20)),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
  
  Widget _buildFrequentContact() {
    return GestureDetector(
      onTap: () => _showDialog('Contact', 'Seid Mohammed\n+251 777 851 925\nDammah, A.R.E.C.A'),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.grey.shade200)),
        child: Row(
          children: [
            Container(width: 45, height: 45, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Center(child: Text('S6', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)))),
            const SizedBox(width: 10),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Seid Mohammed ...', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text('Dammah, A.R.E.C.A', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ])),
            const Icon(Icons.more_vert, size: 18),
          ],
        ),
      ),
    );
  }
  
  void _addMoney() async {
    final controller = TextEditingController();
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Money'),
        content: TextField(controller: controller, decoration: const InputDecoration(labelText: 'Amount (BIRR)'), keyboardType: TextInputType.number),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Add')),
        ],
      ),
    );
    if (result == true && controller.text.isNotEmpty) {
      context.read<UserProvider>().addMoney(double.parse(controller.text));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added ${controller.text} BIRR!'), backgroundColor: Colors.green));
    }
  }
  
  void _showDialog(String title, String content) {
    showDialog(context: context, builder: (context) => AlertDialog(title: Text(title), content: Text(content), actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))]));
  }
}