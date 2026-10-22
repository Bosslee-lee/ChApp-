import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ThanksgivingTab extends StatelessWidget {
  const ThanksgivingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Thanksgiving & Testimonies',
              style: AppFonts.heading(size: 24, color: AppColors.navy)),
          const SizedBox(height: 6),
          Text('Give thanks to the Lord, for He is good.',
              style: AppFonts.body(size: 13, color: AppColors.slate)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppColors.slate.withOpacity(0.12)),
            ),
            child: Column(
              children: [
                Text('Thanksgiving Amount (KES)',
                    style: AppFonts.body(
                        size: 12,
                        weight: FontWeight.w600,
                        color: AppColors.slate)),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.number,
                  style: AppFonts.heading(
                      size: 28, color: AppColors.navy),
                  decoration: InputDecoration(
                    hintText: '0',
                    prefixText: 'KES  ',
                    filled: true,
                    fillColor: AppColors.cream,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 54,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: AppColors.navy,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text('Submit Thanksgiving Offering',
                        style: AppFonts.body(
                            size: 15, weight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}