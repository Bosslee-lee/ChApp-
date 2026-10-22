import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PastorBroadcastTab extends StatelessWidget {
  const PastorBroadcastTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Branch Announcements', style: AppFonts.heading(size: 22, color: AppColors.navy)),
          const SizedBox(height: 4),
          Text('Send messages only to members of your branch.', style: AppFonts.body(size: 13, color: AppColors.slate)),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.slate.withOpacity(0.1))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'Announcement Title', filled: true, fillColor: AppColors.cream, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
                ),
                const SizedBox(height: 12),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(hintText: 'Type your message here...', filled: true, fillColor: AppColors.cream, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message sent to branch!'), backgroundColor: AppColors.green));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold, foregroundColor: AppColors.navy, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                    child: Text('Send to Branch', style: AppFonts.body(size: 15, weight: FontWeight.w700)),
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