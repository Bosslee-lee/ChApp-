import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AdminFinancialsTab extends StatefulWidget {
  const AdminFinancialsTab({super.key});

  @override
  State<AdminFinancialsTab> createState() => _AdminFinancialsTabState();
}

class _AdminFinancialsTabState extends State<AdminFinancialsTab> {
  // State for the filter (Branch vs Group)
  String _viewMode = 'By Branch';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('System Financials', style: AppFonts.heading(size: 22, color: AppColors.navy)),
              IconButton(
                icon: const Icon(Icons.download, color: AppColors.gold),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Exporting Financial PDF...'), backgroundColor: AppColors.green),
                  );
                },
                tooltip: 'Export PDF',
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('Overall church collections and treasury overview.', style: AppFonts.body(size: 13, color: AppColors.slate)),
          const SizedBox(height: 24),

          // 1. TOTAL INCOME CARD
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.navy, Color(0xFF0F1D33)],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: AppColors.navy.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Collected This Month', style: AppFonts.body(size: 13, color: Colors.white.withOpacity(0.7))),
                const SizedBox(height: 4),
                Text('KES 450,000', style: AppFonts.heading(size: 32, color: AppColors.gold)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _headerStat('Tithes', 'KES 250K'),
                    const SizedBox(width: 20),
                    _headerStat('Offerings', 'KES 120K'),
                    const SizedBox(width: 20),
                    _headerStat('Thanksgiving', 'KES 80K'),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 2. BREAKDOWN TOGGLE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Income Breakdown', style: AppFonts.heading(size: 18, color: AppColors.navy)),
              // Toggle Switch
              Container(
                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.slate.withOpacity(0.2))),
                child: Row(
                  children: [
                    _toggleBtn('By Branch', _viewMode == 'By Branch', () => setState(() => _viewMode = 'By Branch')),
                    _toggleBtn('By Group', _viewMode == 'By Group', () => setState(() => _viewMode = 'By Group')),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 3. BREAKDOWN LIST (Changes based on toggle)
          if (_viewMode == 'By Branch') ...[
            _branchBreakdown('AIC — Central Branch', 'KES 250,000', 0.85),
            _branchBreakdown('AIC — Westlands', 'KES 120,000', 0.60),
            _branchBreakdown('AIC — Karen', 'KES 80,000', 0.35),
          ] else ...[
            _groupBreakdown('Main Church Tithes', 'KES 250,000', Icons.church),
            _groupBreakdown('Building Project', 'KES 100,000', Icons.apartment),
            _groupBreakdown('Women\'s Guild', 'KES 45,000', Icons.female),
            _groupBreakdown('Youth Ministry', 'KES 35,000', Icons.local_fire_department),
            _groupBreakdown('Men\'s Fellowship', 'KES 20,000', Icons.male),
          ],

          const SizedBox(height: 32),

          // 4. SYSTEM AUTO-VERIFICATION BANNER
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.green.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: AppColors.green.withOpacity(0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.check_circle, color: AppColors.green),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Auto-Verified by System', style: AppFonts.body(size: 14, weight: FontWeight.w700, color: AppColors.navy)),
                      const SizedBox(height: 2),
                      Text('948 transactions processed automatically.', style: AppFonts.body(size: 12, color: AppColors.slate)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 5. HIGH-VALUE EXCEPTIONS
          Text('High-Value Exceptions', style: AppFonts.heading(size: 18, color: AppColors.navy)),
          const SizedBox(height: 4),
          Text('Transactions over KES 100,000 awaiting Admin sign-off.', style: AppFonts.body(size: 12, color: AppColors.slate)),
          const SizedBox(height: 12),

          _highValueTx('Church Building Fund', 'AIC Central', 'QGH7X8Y2LK', 'KES 500,000'),
          _highValueTx('Anonymous Donor', 'AIC Westlands', 'QGH4P3M1NB', 'KES 250,000'),
        ],
      ),
    );
  }

  // --- WIDGETS ---

  Widget _headerStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.body(size: 11, color: Colors.white.withOpacity(0.6))),
        Text(value, style: AppFonts.body(size: 13, weight: FontWeight.w700, color: Colors.white)),
      ],
    );
  }

  Widget _toggleBtn(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: active ? AppColors.gold : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
            label,
            style: AppFonts.body(size: 12, weight: FontWeight.w700, color: active ? AppColors.navy : AppColors.slate)
        ),
      ),
    );
  }

  Widget _branchBreakdown(String name, String amount, double percent) {
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
              backgroundColor: AppColors.navy.withOpacity(0.08),
              valueColor: const AlwaysStoppedAnimation(AppColors.gold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _groupBreakdown(String name, String amount, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.slate.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.gold),
          const SizedBox(width: 12),
          Expanded(child: Text(name, style: AppFonts.body(size: 13, weight: FontWeight.w600))),
          Text(amount, style: AppFonts.body(size: 13, weight: FontWeight.w700, color: AppColors.navy)),
        ],
      ),
    );
  }

  Widget _highValueTx(String name, String branch, String code, String amount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withOpacity(0.5)),
        boxShadow: [BoxShadow(color: Colors.orange.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: AppFonts.body(size: 14, weight: FontWeight.w700)),
              Text(amount, style: AppFonts.body(size: 16, weight: FontWeight.w700, color: AppColors.navy)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$branch · $code', style: AppFonts.body(size: 12, color: AppColors.slate)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.orange.withOpacity(0.15), borderRadius: BorderRadius.circular(4)),
                child: Text('High Value', style: AppFonts.body(size: 9, weight: FontWeight.w700, color: Colors.orange)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Approved by Admin!'), backgroundColor: AppColors.green),
                    );
                  },
                  icon: const Icon(Icons.verified, size: 16),
                  label: const Text('Sign Off'),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.navy, foregroundColor: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.call, size: 16),
                  label: const Text('Contact Donor'),
                  style: OutlinedButton.styleFrom(foregroundColor: AppColors.navy, side: BorderSide(color: AppColors.slate.withOpacity(0.3))),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}