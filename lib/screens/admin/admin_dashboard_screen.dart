import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

// Import the tabs
import 'tabs/admin_overview_tab.dart';
import 'tabs/admin_members_tab.dart';
import 'tabs/admin_financials_tab.dart';
import 'tabs/admin_broadcast_tab.dart';

// Import the management screens
import 'admin_management_screens.dart';
import 'admin_settings_screens.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _currentTab = 0;

  final List<Map<String, dynamic>> _tabs = [
    {'icon': Icons.dashboard_outlined, 'activeIcon': Icons.dashboard, 'label': 'Overview'},
    {'icon': Icons.people_outline, 'activeIcon': Icons.people, 'label': 'Members'},
    {'icon': Icons.account_balance_wallet_outlined, 'activeIcon': Icons.account_balance_wallet, 'label': 'Financials'},
    {'icon': Icons.campaign_outlined, 'activeIcon': Icons.campaign, 'label': 'Broadcast'},
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
        title: Text('Admin Console', style: AppFonts.heading(size: 20, color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      drawer: _buildAdminDrawer(),
      body: IndexedStack(
        index: _currentTab,
        children: const [
          AdminOverviewTab(),
          AdminMembersTab(),
          AdminFinancialsTab(),
          AdminBroadcastTab(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -4))],
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
                            active ? _tabs[i]['activeIcon'] as IconData : _tabs[i]['icon'] as IconData,
                            color: active ? AppColors.gold : AppColors.slate,
                            size: 24,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _tabs[i]['label'] as String,
                            style: AppFonts.body(
                              size: 11,
                              weight: active ? FontWeight.w700 : FontWeight.w500,
                              color: active ? AppColors.gold : AppColors.slate,
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

  // ─── ADMIN DRAWER ──────────────────────────────────────────
  Widget _buildAdminDrawer() {
    return Drawer(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 24, 20, 24),
            decoration: const BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(28)),
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
                  child: const Center(child: Icon(Icons.admin_panel_settings, size: 34, color: AppColors.navy)),
                ),
                const SizedBox(height: 14),
                Text('Bishop / Admin Office', style: AppFonts.heading(size: 18, color: Colors.white)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                  child: Text('MAIN CHURCH ADMIN', style: AppFonts.body(size: 10, weight: FontWeight.w700, color: AppColors.gold)),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                _drawerItem(
                  Icons.location_city,
                  'Branch & Regional Mgt',
                  onTap: () => _navigate(context, BranchManagementScreen()),
                ),
                _drawerItem(
                  Icons.groups,
                  'Department Management',
                  onTap: () => _navigate(context, DepartmentManagementScreen()),
                ),
                _drawerItem(
                  Icons.handshake,
                  'Fellowship & Small Groups',
                  onTap: () => _navigate(context, FellowshipManagementScreen()),
                ),
                _drawerItem(
                  Icons.badge,
                  'Member ID Generator',
                  onTap: () => _navigate(context, MemberIdGeneratorScreen()),
                ),
                _drawerItem(
                  Icons.campaign,
                  'Global Announcements',
                  onTap: () => _navigate(context, GlobalAnnouncementsScreen()),
                ),
                _drawerItem(
                  Icons.lock,
                  'Role-Based Access Control',
                  onTap: () => _navigate(context, RoleAccessControlScreen()),
                ),
                _drawerItem(
                  Icons.history,
                  'System Audit Logs',
                  onTap: () => _navigate(context, SystemAuditLogsScreen()),
                ),
                _drawerItem(
                  Icons.settings,
                  'System & Payment Settings',
                  onTap: () => _navigate(context, SystemPaymentSettingsScreen()),
                ),
                const Divider(height: 24, indent: 24, endIndent: 24),
                _drawerItem(
                  Icons.logout,
                  'Logout',
                  color: Colors.redAccent,
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    Navigator.pop(context); // Pop Admin Dashboard (Back to Login)
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to close drawer first, then navigate
  void _navigate(BuildContext context, Widget screen) {
    Navigator.pop(context); // Close the drawer
    Future.delayed(const Duration(milliseconds: 200), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    });
  }

  Widget _drawerItem(IconData icon, String label, {Color? color, VoidCallback? onTap}) {
    final c = color ?? AppColors.navy;
    return ListTile(
      leading: Icon(icon, color: c, size: 22),
      title: Text(
          label,
          style: AppFonts.body(size: 14, weight: FontWeight.w500, color: color ?? AppColors.charcoal)
      ),
      onTap: onTap ?? () => Navigator.pop(context),
      horizontalTitleGap: 8,
    );
  }
}