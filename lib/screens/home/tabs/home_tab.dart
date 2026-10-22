import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/give_flow_sheet.dart';
import '../statement_screen.dart'; // Corrected path

class HomeTab extends StatelessWidget {
  final String memberName;
  final String branch;

  const HomeTab({
    super.key,
    required this.memberName,
    required this.branch,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _welcomeCard(),
          const SizedBox(height: 24),
          _quickActions(context),
          const SizedBox(height: 28),
          _recentActivity(),
        ],
      ),
    );
  }

  // ---- WELCOME CARD ----
  Widget _welcomeCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navy, Color(0xFF0F1D33)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back,',
            style: AppFonts.body(
              size: 13,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            memberName,
            style: AppFonts.heading(size: 24, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Container(height: 1, color: Colors.white.withOpacity(0.12)),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Given This Month',
                      style: AppFonts.body(
                        size: 11,
                        color: Colors.white.withOpacity(0.65),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'KES 12,500',
                      style: AppFonts.heading(
                        size: 22,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.15),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Contribution',
                      style: AppFonts.body(
                        size: 11,
                        color: Colors.white.withOpacity(0.65),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Oct 15, 2026',
                      style: AppFonts.body(
                        size: 14,
                        weight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---- QUICK ACTIONS ----
  Widget _quickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _actionButton(
            icon: Icons.send_rounded,
            label: 'Give Now',
            filled: true,
            onTap: () => showGiveFlow(context),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _actionButton(
            icon: Icons.receipt_long_outlined,
            label: 'View Statement',
            filled: false,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const StatementScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String label,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: filled ? AppColors.gold : AppColors.white,
          foregroundColor: AppColors.navy,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: filled
                ? BorderSide.none
                : BorderSide(color: AppColors.slate.withOpacity(0.2)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 6),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: AppFonts.body(size: 14, weight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- RECENT ACTIVITY ----
  Widget _recentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              'Recent Activity',
              style: AppFonts.heading(size: 18, color: AppColors.navy),
            ),
            const Spacer(),
            Text(
              'See all',
              style: AppFonts.body(
                size: 13,
                weight: FontWeight.w600,
                color: AppColors.gold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _activityTile(
          category: 'Tithe',
          date: 'Oct 15, 2026',
          amount: 'KES 5,000',
          mpesa: 'QGH7X8Y2LK',
          color: AppColors.gold,
          icon: Icons.church,
        ),
        _activityTile(
          category: 'Offering',
          date: 'Oct 12, 2026',
          amount: 'KES 2,500',
          mpesa: 'QGH4P3M1NB',
          color: AppColors.green,
          icon: Icons.volunteer_activism,
        ),
        _activityTile(
          category: 'Thanksgiving',
          date: 'Oct 8, 2026',
          amount: 'KES 5,000',
          mpesa: 'QGH2W9C5KD',
          color: AppColors.navy,
          icon: Icons.celebration,
        ),
      ],
    );
  }

  Widget _activityTile({
    required String category,
    required String date,
    required String amount,
    required String mpesa,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.slate.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      category,
                      style: AppFonts.body(
                        size: 14,
                        weight: FontWeight.w700,
                        color: AppColors.charcoal,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.green.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Validated',
                        style: AppFonts.body(
                          size: 9,
                          weight: FontWeight.w700,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  '$date  ·  $mpesa',
                  style: AppFonts.body(size: 11, color: AppColors.slate),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: AppFonts.body(
              size: 14,
              weight: FontWeight.w700,
              color: AppColors.navy,
            ),
          ),
        ],
      ),
    );
  }
}