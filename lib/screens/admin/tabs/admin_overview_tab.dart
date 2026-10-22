import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/admin_forms.dart'; // <-- This is the important import

class AdminOverviewTab extends StatelessWidget {
  const AdminOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // KPI GRID
          Row(
            children: [
              Expanded(child: _kpiCard('Total Members', '1,240', '+12%', Icons.people_alt, AppColors.green)),
              const SizedBox(width: 12),
              Expanded(child: _kpiCard('Active Branches', '4', '2 new', Icons.location_city, AppColors.navy)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _kpiCard('Monthly Income', 'KES 450K', '+8%', Icons.account_balance_wallet, AppColors.gold)),
              const SizedBox(width: 12),
              Expanded(child: _kpiCard('Pending IDs', '8', 'Action needed', Icons.pending_actions, Colors.orange)),
            ],
          ),
          const SizedBox(height: 24),

          // QUICK ACTIONS (Now wired to the forms)
          Text('Quick Actions', style: AppFonts.heading(size: 18, color: AppColors.navy)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _actionChip('+ Add Branch', () => showAddBranchForm(context)),
              _actionChip('+ Create Dept', () => showCreateDepartmentForm(context)),
              _actionChip('+ Fellowship', () => showCreateFellowshipForm(context)),
              _actionChip('Post Announcement', () => showPostAnnouncementForm(context)),
            ],
          ),
          const SizedBox(height: 24),

          // BRANCH PERFORMANCE
          Text('Branch Financial Breakdown', style: AppFonts.heading(size: 18, color: AppColors.navy)),
          const SizedBox(height: 12),
          _branchBar('AIC Central', 0.85, 'KES 250,000'),
          _branchBar('AIC Westlands', 0.60, 'KES 120,000'),
          _branchBar('AIC Karen', 0.35, 'KES 80,000'),
        ],
      ),
    );
  }

  Widget _kpiCard(String title, String value, String trend, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Text(trend, style: AppFonts.body(size: 10, weight: FontWeight.w700, color: color)),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: AppFonts.heading(size: 20, color: AppColors.navy)),
          Text(title, style: AppFonts.body(size: 12, color: AppColors.slate)),
        ],
      ),
    );
  }

  Widget _actionChip(String label, VoidCallback onTap) {
    return ActionChip(
      label: Text(label, style: AppFonts.body(size: 12, weight: FontWeight.w600)),
      onPressed: onTap,
      backgroundColor: AppColors.white,
      side: BorderSide(color: AppColors.slate.withOpacity(0.2)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _branchBar(String name, double percent, String amount) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: AppFonts.body(size: 13, weight: FontWeight.w600)),
              Text(amount, style: AppFonts.body(size: 13, weight: FontWeight.w700, color: AppColors.navy)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 8,
              backgroundColor: AppColors.navy.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation(AppColors.gold),
            ),
          ),
        ],
      ),
    );
  }
}