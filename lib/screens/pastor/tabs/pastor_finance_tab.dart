import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PastorFinanceTab extends StatelessWidget {
  const PastorFinanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Branch Financials', style: AppFonts.heading(size: 22, color: AppColors.navy)),
          const SizedBox(height: 4),
          Text('Income generated directly from this branch.', style: AppFonts.body(size: 13, color: AppColors.slate)),
          const SizedBox(height: 24),

          // Total Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.navy, Color(0xFF0F1D33)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Collected (Month)', style: AppFonts.body(size: 13, color: Colors.white.withOpacity(0.7))),
                const SizedBox(height: 4),
                Text('KES 57,000', style: AppFonts.heading(size: 32, color: AppColors.gold)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _headerStat('Tithes', 'KES 45K'),
                    const SizedBox(width: 20),
                    _headerStat('Offerings', 'KES 12K'),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 24),

          Text('Breakdown by Category', style: AppFonts.heading(size: 18, color: AppColors.navy)),
          const SizedBox(height: 12),
          _finRow('Tithes', 'KES 45,000', Icons.church),
          _finRow('General Offerings', 'KES 8,000', Icons.volunteer_activism),
          _finRow('Building Fund', 'KES 4,000', Icons.apartment),
        ],
      ),
    );
  }

  Widget _headerStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.body(size: 11, color: Colors.white.withOpacity(0.6))),
        Text(value, style: AppFonts.body(size: 14, weight: FontWeight.w700, color: Colors.white)),
      ],
    );
  }

  Widget _finRow(String title, String amount, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.slate.withOpacity(0.1))),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 22),
          const SizedBox(width: 14),
          Expanded(child: Text(title, style: AppFonts.body(size: 14, weight: FontWeight.w600))),
          Text(amount, style: AppFonts.body(size: 14, weight: FontWeight.w700, color: AppColors.navy)),
        ],
      ),
    );
  }
}