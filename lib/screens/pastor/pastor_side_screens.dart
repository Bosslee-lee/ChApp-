import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

// ============================================================
// 1. BRANCH MEMBERS DIRECTORY
// ============================================================
class BranchDirectoryScreen extends StatelessWidget {
  const BranchDirectoryScreen({super.key});

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
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Branch Members', style: AppFonts.heading(size: 20, color: Colors.white)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
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
    );
  }
}

// ============================================================
// 2. DEPARTMENTS & FELLOWSHIPS
// ============================================================
class DepartmentsFellowshipsScreen extends StatelessWidget {
  const DepartmentsFellowshipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Departments & Fellowships', style: AppFonts.heading(size: 20, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Departments', style: AppFonts.heading(size: 18, color: AppColors.navy)),
            const SizedBox(height: 12),
            _groupTile('Choir & Worship', '45 members', 'Head: John Mwangi', Icons.music_note),
            _groupTile('Ushering', '24 members', 'Head: Mary W.', Icons.groups),
            _groupTile('Media & Tech', '12 members', 'Head: Peter K.', Icons.camera_alt),
            const SizedBox(height: 24),
            Text('Fellowships', style: AppFonts.heading(size: 18, color: AppColors.navy)),
            const SizedBox(height: 12),
            _groupTile('Men\'s Fellowship', '65 members', 'Leader: Deacon Paul', Icons.male),
            _groupTile('Women\'s Guild', '120 members', 'Leader: Sarah K.', Icons.female),
            _groupTile('Youth Ministry', '85 members', 'Leader: Youth Pastor', Icons.local_fire_department),
          ],
        ),
      ),
    );
  }

  Widget _groupTile(String title, String members, String leader, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.slate.withOpacity(0.1))),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: AppColors.gold, size: 22)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppFonts.body(size: 14, weight: FontWeight.w700)),
                Text('$leader · $members', style: AppFonts.body(size: 12, color: AppColors.slate)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 3. BRANCH ANNOUNCEMENTS
// ============================================================
class BranchAnnouncementsScreen extends StatelessWidget {
  const BranchAnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Branch Announcements', style: AppFonts.heading(size: 20, color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _announcementTile('Sunday Service Update', 'Join us at 9 AM for a powerful message.', 'Today, 8:30 AM', true),
          _announcementTile('Youth Camp Registration', 'Registration is now open for all youth.', 'Oct 25, 2026', false),
          _announcementTile('Building Fund Update', 'We are 65% towards our goal!', 'Oct 12, 2026', false),
        ],
      ),
    );
  }

  Widget _announcementTile(String title, String body, String date, bool isPinned) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: isPinned ? AppColors.gold.withOpacity(0.3) : AppColors.slate.withOpacity(0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isPinned) ...[const Icon(Icons.push_pin, color: AppColors.gold, size: 16), const SizedBox(width: 6)],
              Expanded(child: Text(title, style: AppFonts.body(size: 15, weight: FontWeight.w700))),
              Text(date, style: AppFonts.body(size: 11, color: AppColors.slate)),
            ],
          ),
          const SizedBox(height: 8),
          Text(body, style: AppFonts.body(size: 13, color: AppColors.charcoal)),
        ],
      ),
    );
  }
}

// ============================================================
// 4. BRANCH FINANCIALS
// ============================================================
class BranchFinancialsScreen extends StatelessWidget {
  const BranchFinancialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Branch Financials', style: AppFonts.heading(size: 20, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.navy, Color(0xFF0F1D33)]), borderRadius: BorderRadius.circular(20)),
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
            Text('Breakdown', style: AppFonts.heading(size: 18, color: AppColors.navy)),
            const SizedBox(height: 12),
            _finRow('Tithes', 'KES 45,000', Icons.church),
            _finRow('General Offerings', 'KES 8,000', Icons.volunteer_activism),
            _finRow('Building Fund', 'KES 4,000', Icons.apartment),
          ],
        ),
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