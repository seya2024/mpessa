import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class BuyPackagesScreen extends StatelessWidget {
  const BuyPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buy Packages')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _packageCard('Internet Bundle', '3GB + 60min', '100 BIRR', '30 days'),
          _packageCard('Social Bundle', '1GB (Social Media)', '50 BIRR', '7 days'),
          _packageCard('Night Bundle', '10GB (12AM-6AM)', '75 BIRR', '30 days'),
          _packageCard('Weekly Bundle', '1.5GB + 30min', '60 BIRR', '7 days'),
          _packageCard('Monthly Bundle', '8GB + 200min', '200 BIRR', '30 days'),
        ],
      ),
    );
  }
  
  Widget _packageCard(String title, String details, String price, String validity) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.shopping_bag, color: AppColors.primary)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(details), Text(validity, style: const TextStyle(fontSize: 12, color: Colors.grey))]),
        trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
          const SizedBox(height: 4),
          ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, minimumSize: const Size(60, 30)), child: const Text('Buy', style: TextStyle(fontSize: 12))),
        ]),
      ),
    );
  }
}