import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'tabs/home_tab.dart';
import 'tabs/tithes_tab.dart';
import 'tabs/offerings_tab.dart';
import 'tabs/thanksgiving_tab.dart';
import 'drawer_screens.dart';

class MemberHomeScreen extends StatefulWidget {
  final String email;
  final String role;
  final String? leaderCode;

  const MemberHomeScreen({
    super.key,
    required this.email,
    required this.role,
    this.leaderCode,
  });

  @override
  State<MemberHomeScreen> createState() => _MemberHomeScreenState();
}

class _MemberHomeScreenState extends State<MemberHomeScreen> {
  int _currentTab = 0;
  String _selectedBranch = 'AIC — Central Branch';

  final String _memberName = 'John Mwangi';
  final String _memberPhone = '+254 712 345 678';

  static const _tabs = [
    {'icon': Icons.home_outlined, 'activeIcon': Icons.home, 'label': 'Home'},
    {'icon': Icons.church_outlined, 'activeIcon': Icons.church, 'label': 'Tithes'},
    {
      'icon': Icons.volunteer_activism_outlined,
      'activeIcon': Icons.volunteer_activism,
      'label': 'Offerings'
    },
    {
      'icon': Icons.celebration_outlined,
      'activeIcon': Icons.celebration,
      'label': 'Thanksgiving'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        elevation: 0,
        leading: Builder(
          builder: (ctx) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(ctx).openDrawer(),
          ),
        ),
        title: _branchSelector(),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      drawer: _buildDrawer(),
      body: IndexedStack(
        index: _currentTab,
        children: [
          HomeTab(
            memberName: _memberName,
            branch: _selectedBranch,
          ),
          const TithesTab(),
          const OfferingsTab(),
          const ThanksgivingTab(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_tabs.length, (i) {
                final active = _currentTab == i;
                return Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _currentTab = i),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            active
                                ? _tabs[i]['activeIcon'] as IconData
                                : _tabs[i]['icon'] as IconData,
                            color:
                            active ? AppColors.gold : AppColors.slate,
                            size: 24,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _tabs[i]['label'] as String,
                            style: AppFonts.body(
                              size: 11,
                              weight: active
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: active
                                  ? AppColors.gold
                                  : AppColors.slate,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _branchSelector() {
    final branches = [
      'AIC — Central Branch',
      'AIC — Westlands',
      'AIC — Eastleigh',
      'AIC — Karen',
    ];
    return PopupMenuButton<String>(
      initialValue: _selectedBranch,
      onSelected: (v) => setState(() => _selectedBranch = v),
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      itemBuilder: (_) => branches
          .map((b) => PopupMenuItem(
        value: b,
        child: Row(
          children: [
            Icon(
              b == _selectedBranch
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              size: 18,
              color: b == _selectedBranch
                  ? AppColors.gold
                  : AppColors.slate,
            ),
            const SizedBox(width: 10),
            Text(b, style: AppFonts.body(size: 14)),
          ],
        ),
      ))
          .toList(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on_outlined,
              color: Colors.white, size: 18),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              _selectedBranch,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.body(
                size: 14,
                weight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_down,
              color: Colors.white, size: 18),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).padding.top + 24,
              20,
              24,
            ),
            decoration: const BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Center(
                    child: Icon(Icons.person,
                        size: 34, color: AppColors.navy),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  _memberName,
                  style: AppFonts.heading(
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _memberPhone,
                  style: AppFonts.body(
                    size: 13,
                    color: Colors.white.withOpacity(0.75),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 12, color: AppColors.gold),
                      const SizedBox(width: 4),
                      Text(
                        _selectedBranch,
                        style: AppFonts.body(
                          size: 11,
                          weight: FontWeight.w600,
                          color: AppColors.gold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                _drawerItem(
                  Icons.person_outline,
                  'Profile & Account',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileScreen()),
                    );
                  },
                ),
                _drawerItem(
                  Icons.receipt_long_outlined,
                  'My Contribution History',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => HistoryScreen()),
                    );
                  },
                ),
                _drawerItem(
                  Icons.download_outlined,
                  'Download Tax / Receipts',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ReceiptsScreen()),
                    );
                  },
                ),
                _drawerItem(
                  Icons.campaign_outlined,
                  'Announcements & Events',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AnnouncementsScreen()),
                    );
                  },
                ),
                _drawerItem(
                  Icons.support_agent_outlined,
                  'Contact Pastor / Helpdesk',
                  onTap: () {
                    Navigator.pop(context); // close drawer first
                    _showContactDialog(context);
                  },
                ),
                const Divider(height: 24, indent: 24, endIndent: 24),
                _drawerItem(
                  Icons.logout,
                  'Logout',
                  color: Colors.redAccent,
                  onTap: () {
                    Navigator.pop(context); // close drawer
                    Navigator.pop(context); // back to login
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('ChApp v1.0', style: AppFonts.caption()),
          ),
        ],
      ),
    );
  }

  // --- Contact Dialog ---
  void _showContactDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Contact Pastor / Helpdesk',
              style: AppFonts.heading(size: 20, color: AppColors.navy),
            ),
            const SizedBox(height: 8),
            Text(
              'How would you like to reach us?',
              style: AppFonts.body(size: 14, color: AppColors.slate),
            ),
            const SizedBox(height: 24),
            _contactOption(
              icon: Icons.phone_in_talk_outlined,
              label: 'Call Church Office',
              color: AppColors.navy,
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Launching Phone Dialer...')),
                );
              },
            ),
            const SizedBox(height: 12),
            _contactOption(
              icon: Icons.chat_bubble_outline,
              label: 'Message on WhatsApp',
              color: AppColors.green,
              onTap: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Opening WhatsApp...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(14),
          color: color.withOpacity(0.05),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: AppFonts.body(
                  size: 15,
                  weight: FontWeight.w700,
                  color: color,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: color),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String label,
      {Color? color, VoidCallback? onTap}) {
    final c = color ?? AppColors.navy;
    return ListTile(
      leading: Icon(icon, color: c, size: 22),
      title: Text(
        label,
        style: AppFonts.body(
          size: 14,
          weight: FontWeight.w500,
          color: color ?? AppColors.charcoal,
        ),
      ),
      onTap: onTap ?? () => Navigator.pop(context),
      horizontalTitleGap: 8,
    );
  }
}