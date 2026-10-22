import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PastorOverviewTab extends StatelessWidget {
  final String branchName;
  const PastorOverviewTab({super.key, required this.branchName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.navy, Color(0xFF0F1D33)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                  child: Text('PASTORAL OVERVIEW', style: AppFonts.body(size: 10, weight: FontWeight.w700, color: AppColors.gold)),
                ),
                const SizedBox(height: 12),
                Text(branchName, style: AppFonts.heading(size: 24, color: Colors.white)),
                const SizedBox(height: 4),
                Text('Branch metrics and congregation overview.', style: AppFonts.body(size: 13, color: Colors.white.withOpacity(0.7))),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _kpiCard('Total Members', '320', Icons.people, AppColors.green)),
              const SizedBox(width: 12),
              Expanded(child: _kpiCard('Active Leaders', '8', Icons.admin_panel_settings, AppColors.gold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _kpiCard('Departments', '5', Icons.groups, AppColors.navy)),
              const SizedBox(width: 12),
              Expanded(child: _kpiCard('Fellowships', '3', Icons.handshake, AppColors.slate)),
            ],
          ),
          const SizedBox(height: 28),
          Text('Branch Overview', style: AppFonts.heading(size: 18, color: AppColors.navy)),
          const SizedBox(height: 12),
          _branchStatRow('Men\'s Fellowship', '45 members', Icons.male),
          _branchStatRow('Women\'s Guild', '120 members', Icons.female),
          _branchStatRow('Youth Ministry', '85 members', Icons.local_fire_department),
          _branchStatRow('Sunday School', '70 members', Icons.child_care),
        ],
      ),
    );
  }

  Widget _kpiCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.slate.withOpacity(0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(value, style: AppFonts.heading(size: 22, color: AppColors.navy)),
          Text(title, style: AppFonts.body(size: 12, color: AppColors.slate)),
        ],
      ),
    );
  }

  Widget _branchStatRow(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.slate.withOpacity(0.1))),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: AppFonts.body(size: 14, weight: FontWeight.w600))),
          Text(subtitle, style: AppFonts.body(size: 12, color: AppColors.slate)),
        ],
      ),
    );
  }
}