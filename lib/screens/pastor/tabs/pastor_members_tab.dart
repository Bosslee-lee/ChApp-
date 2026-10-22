import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PastorMembersTab extends StatelessWidget {
  const PastorMembersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final members = [
      {'name': 'John Mwangi', 'role': 'Member', 'isLeader': false},
      {'name': 'Jane Wanjiru', 'role': 'Head of Ushering', 'isLeader': true},
      {'name': 'Peter Kamau', 'role': 'Youth Leader', 'isLeader': true},
      {'name': 'Mary Atieno', 'role': 'Member', 'isLeader': false},
    ];

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Branch Members', style: AppFonts.heading(size: 22, color: AppColors.navy)),
                const SizedBox(height: 4),
                Text('View and manage your congregation.', style: AppFonts.body(size: 13, color: AppColors.slate)),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search members...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.slate),
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: members.length,
              itemBuilder: (context, index) {
                final m = members[index];
                final isLeader = m['isLeader'] as bool;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.slate.withOpacity(0.1))),
                  child: Row(
                    children: [
                      CircleAvatar(backgroundColor: isLeader ? AppColors.gold.withOpacity(0.2) : AppColors.navy.withOpacity(0.05), child: Icon(Icons.person, color: isLeader ? AppColors.gold : AppColors.navy)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(m['name'] as String, style: AppFonts.body(size: 14, weight: FontWeight.w700)),
                                if (isLeader) ...[const SizedBox(width: 4), const Icon(Icons.verified, color: AppColors.gold, size: 16)],
                              ],
                            ),
                            Text(m['role'] as String, style: AppFonts.body(size: 12, color: AppColors.slate)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}