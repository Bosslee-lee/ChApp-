import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

// ============================================================
// 1. MEMBER ID GENERATOR SCREEN (PROFESSIONAL)
// ============================================================
class MemberIdGeneratorScreen extends StatefulWidget {
  const MemberIdGeneratorScreen({super.key});

  @override
  State<MemberIdGeneratorScreen> createState() => _MemberIdGeneratorScreenState();
}

class _MemberIdGeneratorScreenState extends State<MemberIdGeneratorScreen> {
  // Mock list of members (In real app, fetch from Firestore)
  final List<Map<String, String>> _members = [
    {'name': 'John Mwangi', 'email': 'john@gmail.com', 'branch': 'AIC Central'},
    {'name': 'Jane Wanjiru', 'email': 'jane@gmail.com', 'branch': 'AIC Westlands'},
    {'name': 'Peter Kamau', 'email': 'peter@gmail.com', 'branch': 'AIC Karen'},
    {'name': 'Mary Atieno', 'email': 'mary@gmail.com', 'branch': 'AIC Central'},
  ];

  // Role options with descriptions
  final List<Map<String, String>> _roles = [
    {'title': 'Head of ICT', 'code': 'ICT', 'desc': 'System & media management'},
    {'title': 'Head of Ushering', 'code': 'USH', 'desc': 'Welcome & seating management'},
    {'title': 'Treasurer', 'code': 'TRE', 'desc': 'Financial verification'},
    {'title': 'Youth Leader', 'code': 'YTH', 'desc': 'Youth ministry oversight'},
    {'title': 'Pastor', 'code': 'PST', 'desc': 'Spiritual oversight'},
  ];

  // State
  Map<String, String>? _selectedMember;
  String _selectedRoleCode = 'ICT';
  String _generatedId = '';
  bool _isGenerating = false;

  // Mock list of recent IDs
  final List<Map<String, String>> _recentIds = [
    {'name': 'Peter Kamau', 'id': 'ICT-2026-4821', 'role': 'Head of ICT', 'date': 'Today, 10:15 AM'},
    {'name': 'Mary Atieno', 'id': 'TRE-2026-1104', 'role': 'Treasurer', 'date': 'Yesterday, 2:30 PM'},
  ];

  void _generateId() {
    if (_selectedMember == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a member first.'), backgroundColor: Colors.redAccent),
      );
      return;
    }

    setState(() => _isGenerating = true);

    // Simulate server call
    Future.delayed(const Duration(seconds: 1), () {
      final year = DateTime.now().year;
      final randomNum = (1000 + DateTime.now().millisecond % 9000);
      final newId = '$_selectedRoleCode-$year-$randomNum';

      setState(() {
        _isGenerating = false;
        _generatedId = newId;

        // Add to recent list
        _recentIds.insert(0, {
          'name': _selectedMember!['name']!,
          'id': newId,
          'role': _roles.firstWhere((r) => r['code'] == _selectedRoleCode)['title']!,
          'date': 'Just now',
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Member ID Generator', style: AppFonts.heading(size: 20, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ─── STEP 1: SELECT MEMBER ───────────────────────
            Text('1. Select Member', style: AppFonts.heading(size: 18, color: AppColors.navy)),
            const SizedBox(height: 4),
            Text('Search for the leader you want to assign a code to.', style: AppFonts.body(size: 13, color: AppColors.slate)),
            const SizedBox(height: 12),

            Container(
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.slate.withOpacity(0.1))),
              child: Column(
                children: _members.map((m) {
                  final isSelected = _selectedMember?['email'] == m['email'];
                  return ListTile(
                    onTap: () => setState(() {
                      _selectedMember = m;
                      _generatedId = '';
                    }),
                    leading: CircleAvatar(
                      backgroundColor: isSelected ? AppColors.gold : AppColors.navy.withOpacity(0.05),
                      child: Icon(Icons.person, color: isSelected ? AppColors.navy : AppColors.navy),
                    ),
                    title: Text(m['name']!, style: AppFonts.body(size: 14, weight: FontWeight.w700)),
                    subtitle: Text('${m['email']} · ${m['branch']}', style: AppFonts.body(size: 11, color: AppColors.slate)),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: AppColors.green)
                        : const Icon(Icons.chevron_right, color: AppColors.slate),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 28),

            // ─── STEP 2: SELECT ROLE ─────────────────────────
            Text('2. Assign Role', style: AppFonts.heading(size: 18, color: AppColors.navy)),
            const SizedBox(height: 4),
            Text('Choose the role that this ID will unlock.', style: AppFonts.body(size: 13, color: AppColors.slate)),
            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _roles.map((r) {
                final isActive = _selectedRoleCode == r['code'];
                return InkWell(
                  onTap: () => setState(() => _selectedRoleCode = r['code']!),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.navy : AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: isActive ? AppColors.navy : AppColors.slate.withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r['title']!, style: AppFonts.body(size: 13, weight: FontWeight.w700, color: isActive ? Colors.white : AppColors.navy)),
                        const SizedBox(height: 2),
                        Text(r['desc']!, style: AppFonts.body(size: 10, color: isActive ? Colors.white.withOpacity(0.7) : AppColors.slate)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 32),

            // ─── STEP 3: GENERATE ────────────────────────────
            SizedBox(
              height: 54,
              child: ElevatedButton(
                onPressed: _isGenerating ? null : _generateId,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: AppColors.navy,
                  disabledBackgroundColor: AppColors.gold.withOpacity(0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: _isGenerating
                    ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: AppColors.navy, strokeWidth: 2.5))
                    : Text('Generate Login ID', style: AppFonts.body(size: 16, weight: FontWeight.w700)),
              ),
            ),

            // ─── RESULT CARD ─────────────────────────────────
            if (_generatedId.isNotEmpty) ...[
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.navy, Color(0xFF0F1D33)]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: AppColors.navy.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 8))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.verified, color: AppColors.green, size: 24),
                        const SizedBox(width: 8),
                        Text('ID Generated Successfully', style: AppFonts.body(size: 14, weight: FontWeight.w700, color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Member', style: AppFonts.body(size: 11, color: Colors.white.withOpacity(0.6))),
                    Text(_selectedMember?['name'] ?? '', style: AppFonts.body(size: 16, weight: FontWeight.w700, color: Colors.white)),
                    const SizedBox(height: 12),
                    Text('Login Code', style: AppFonts.body(size: 11, color: Colors.white.withOpacity(0.6))),
                    Text(_generatedId, style: AppFonts.heading(size: 28, color: AppColors.gold)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to clipboard!'), backgroundColor: AppColors.green));
                            },
                            icon: const Icon(Icons.copy, size: 16, color: Colors.white),
                            label: Text('Copy Code', style: AppFonts.body(size: 13, weight: FontWeight.w700, color: Colors.white)),
                            style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.white.withOpacity(0.4)), padding: const EdgeInsets.symmetric(vertical: 12)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.share, size: 16, color: Colors.white),
                            label: Text('Share', style: AppFonts.body(size: 13, weight: FontWeight.w700, color: Colors.white)),
                            style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.white.withOpacity(0.4)), padding: const EdgeInsets.symmetric(vertical: 12)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 32),

            // ─── RECENT IDS ──────────────────────────────────
            Text('Recently Generated', style: AppFonts.heading(size: 18, color: AppColors.navy)),
            const SizedBox(height: 12),

            ..._recentIds.map((r) => Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.slate.withOpacity(0.1))),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.badge, color: AppColors.gold, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r['name']!, style: AppFonts.body(size: 13, weight: FontWeight.w700)),
                        Text('${r['role']} · ${r['id']}', style: AppFonts.body(size: 11, color: AppColors.slate)),
                      ],
                    ),
                  ),
                  Text(r['date']!, style: AppFonts.body(size: 10, color: AppColors.slate)),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 2. GLOBAL ANNOUNCEMENTS SCREEN
// ============================================================
class GlobalAnnouncementsScreen extends StatelessWidget {
  const GlobalAnnouncementsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(backgroundColor: AppColors.navy, iconTheme: const IconThemeData(color: Colors.white), title: Text('Global Announcements', style: AppFonts.heading(size: 20, color: Colors.white))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Active Announcements', style: AppFonts.heading(size: 18, color: AppColors.navy)),
          const SizedBox(height: 12),
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
// 3. SYSTEM AUDIT LOGS SCREEN
// ============================================================
class SystemAuditLogsScreen extends StatelessWidget {
  const SystemAuditLogsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(backgroundColor: AppColors.navy, iconTheme: const IconThemeData(color: Colors.white), title: Text('System Audit Logs', style: AppFonts.heading(size: 20, color: Colors.white))),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Security & Activity Trail', style: AppFonts.heading(size: 18, color: AppColors.navy)),
          const SizedBox(height: 4),
          Text('All system changes and logins are recorded here.', style: AppFonts.body(size: 12, color: AppColors.slate)),
          const SizedBox(height: 16),
          _logTile('Admin Login', 'Bishop logged in from Nairobi, IP: 192.168.1.1', 'Today, 09:15 AM', AppColors.green),
          _logTile('Role Assigned', 'Jane Wanjiru was promoted to Head of ICT', 'Today, 10:00 AM', AppColors.gold),
          _logTile('Transaction Verified', 'KES 500,000 verified for Building Fund', 'Yesterday, 04:30 PM', AppColors.green),
          _logTile('Failed Login', 'Unknown user tried to log in as Pastor', 'Yesterday, 02:12 AM', Colors.redAccent),
        ],
      ),
    );
  }
  Widget _logTile(String action, String details, String time, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: color.withOpacity(0.2))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: Icon(Icons.security, size: 18, color: color)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(action, style: AppFonts.body(size: 13, weight: FontWeight.w700)),
                    Text(time, style: AppFonts.body(size: 10, color: AppColors.slate)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(details, style: AppFonts.body(size: 12, color: AppColors.slate)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 4. SYSTEM & PAYMENT SETTINGS SCREEN
// ============================================================
class SystemPaymentSettingsScreen extends StatefulWidget {
  const SystemPaymentSettingsScreen({super.key});
  @override
  State<SystemPaymentSettingsScreen> createState() => _SystemPaymentSettingsScreenState();
}

class _SystemPaymentSettingsScreenState extends State<SystemPaymentSettingsScreen> {
  bool _mpesaEnabled = true;
  bool _cardEnabled = false;
  final _paybillCtrl = TextEditingController(text: '174379');
  final _tillCtrl = TextEditingController(text: '0706681096');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(backgroundColor: AppColors.navy, iconTheme: const IconThemeData(color: Colors.white), title: Text('System Settings', style: AppFonts.heading(size: 20, color: Colors.white))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Payment Gateways', style: AppFonts.heading(size: 18, color: AppColors.navy)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.slate.withOpacity(0.1))),
              child: Column(
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('M-Pesa Integration', style: AppFonts.body(size: 14, weight: FontWeight.w700)),
                    subtitle: Text('Accept payments via Safaricom', style: AppFonts.body(size: 12, color: AppColors.slate)),
                    value: _mpesaEnabled,
                    activeColor: AppColors.gold,
                    onChanged: (v) => setState(() => _mpesaEnabled = v),
                  ),
                  if (_mpesaEnabled) ...[
                    const Divider(),
                    const SizedBox(height: 8),
                    TextField(controller: _paybillCtrl, decoration: InputDecoration(labelText: 'Paybill Number', filled: true, fillColor: AppColors.cream, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))),
                    const SizedBox(height: 12),
                    TextField(controller: _tillCtrl, decoration: InputDecoration(labelText: 'Till Number', filled: true, fillColor: AppColors.cream, border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none))),
                  ]
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.slate.withOpacity(0.1))),
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Card Payments', style: AppFonts.body(size: 14, weight: FontWeight.w700)),
                subtitle: Text('Accept Visa/Mastercard', style: AppFonts.body(size: 12, color: AppColors.slate)),
                value: _cardEnabled,
                activeColor: AppColors.gold,
                onChanged: (v) => setState(() => _cardEnabled = v),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 54,
              child: ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings Saved!'), backgroundColor: AppColors.green)),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.navy, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                child: Text('Save Configuration', style: AppFonts.body(size: 15, weight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// 5. ROLE-BASED ACCESS CONTROL SCREEN
// ============================================================
class RoleAccessControlScreen extends StatefulWidget {
  const RoleAccessControlScreen({super.key});
  @override
  State<RoleAccessControlScreen> createState() => _RoleAccessControlScreenState();
}

class _RoleAccessControlScreenState extends State<RoleAccessControlScreen> {
  final List<Map<String, dynamic>> _roles = [
    {'title': 'Pastor / Bishop', 'desc': 'Full access to all church data and financials.', 'icon': Icons.church, 'color': AppColors.gold, 'active': true},
    {'title': 'Treasurer', 'desc': 'Can verify transactions and export financial reports.', 'icon': Icons.account_balance_wallet, 'color': AppColors.green, 'active': true},
    {'title': 'Department Head', 'desc': 'Can manage department members and send group alerts.', 'icon': Icons.groups, 'color': AppColors.navy, 'active': true},
    {'title': 'Usher / Volunteer', 'desc': 'Can view events and record attendance.', 'icon': Icons.handshake, 'color': AppColors.slate, 'active': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(backgroundColor: AppColors.navy, iconTheme: const IconThemeData(color: Colors.white), title: Text('Role Access Control', style: AppFonts.heading(size: 20, color: Colors.white))),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _roles.length,
        itemBuilder: (context, index) {
          final role = _roles[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.slate.withOpacity(0.1))),
            child: Row(
              children: [
                Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: (role['color'] as Color).withOpacity(0.15), borderRadius: BorderRadius.circular(12)), child: Icon(role['icon'] as IconData, color: role['color'] as Color, size: 24)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(role['title'], style: AppFonts.body(size: 15, weight: FontWeight.w700)),
                      const SizedBox(height: 4),
                      Text(role['desc'], style: AppFonts.body(size: 12, color: AppColors.slate)),
                    ],
                  ),
                ),
                Switch(
                  value: role['active'],
                  activeColor: AppColors.green,
                  onChanged: (v) {
                    setState(() => role['active'] = v);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${role['title']} access ${v ? "Enabled" : "Disabled"}'), backgroundColor: v ? AppColors.green : Colors.redAccent));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}