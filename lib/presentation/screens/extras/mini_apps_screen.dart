import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class MiniAppsScreen extends StatelessWidget {
  const MiniAppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Apps')),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _miniApp(Icons.games, 'Games'),
          _miniApp(Icons.music_note, 'Music'),
          _miniApp(Icons.movie, 'Movies'),
          _miniApp(Icons.shopping_cart, 'Shop'),
          _miniApp(Icons.food_bank, 'Food'),
          _miniApp(Icons.school, 'Education'),
          _miniApp(Icons.health_and_safety, 'Health'),
          _miniApp(Icons.sports_soccer, 'Sports'),
          _miniApp(Icons.article, 'News'),
        ],
      ),
    );
  }
  
  Widget _miniApp(IconData icon, String name) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(16)), child: Icon(icon, color: AppColors.primary, size: 32)),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}