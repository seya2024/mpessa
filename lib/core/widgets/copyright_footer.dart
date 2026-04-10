import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../constants/colors.dart';

class CopyrightFooter extends StatelessWidget {
  const CopyrightFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.copyright, size: 10, color: AppColors.textHint),
              const SizedBox(width: 2),
              Text(
                '$currentYear ${AppConstants.appName}. All rights reserved.',
                style: TextStyle(
                  fontSize: 9,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            AppConstants.companyName,
            style: TextStyle(
              fontSize: 8,
              color: AppColors.textHint,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Version ${AppConstants.version} | Terms Apply',
            style: TextStyle(
              fontSize: 7,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }
}