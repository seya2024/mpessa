import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

class SafariScreen extends StatelessWidget {
  const SafariScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Safari.com')),
      body: ListView(
        children: [
          _safariTile(Icons.flight_takeoff, 'Flight Booking', 'Book flights'),
          _safariTile(Icons.hotel, 'Hotel Booking', 'Find hotels'),
          _safariTile(Icons.directions_bus, 'Bus Tickets', 'Book buses'),
          _safariTile(Icons.local_activity, 'Event Tickets', 'Buy tickets'),
        ],
      ),
    );
  }
  
  Widget _safariTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: AppColors.primary)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}