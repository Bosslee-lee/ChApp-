import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'tabs/pastor_overview_tab.dart';
import 'tabs/pastor_members_tab.dart';
import 'tabs/pastor_finance_tab.dart';
import 'tabs/pastor_broadcast_tab.dart';
import 'pastor_side_screens.dart';

class PastorDashboardScreen extends StatefulWidget {
  final String branchName;
  const PastorDashboardScreen({super.key, required this.branchName});

  @override
  State<PastorDashboardScreen> createState() => _PastorDashboardScreenState();
}

class _PastorDashboardScreenState extends State<PastorDashboardScreen> {
  int _currentTab = 0;

  final List<Map<String, dynamic>> _tabs = [
    {'icon': Icons.dashboard_outlined, 'activeIcon': Icons.dashboard, 'label': 'Overview'},
    {'icon': Icons.people_outline, 'activeIcon': Icons.people, 'label': 'Members'},
    {'icon': Icons.account_balance_wallet_outlined, 'activeIcon': Icons.account_balance_wallet, 'label': 'Finance'},
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pastor Console', style: AppFonts.heading(size: 18, color: Colors.white)),
            Text(widget.branchName, style: AppFonts.body(size: 11, color: AppColors.gold)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      drawer: _buildPastorDrawer(),
      body: IndexedStack(
        index: _currentTab,
        children: [
          PastorOverviewTab(branchName: widget.branchName),
          const PastorMembersTab(),
          const PastorFinanceTab(),
          const PastorBroadcastTab(),
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

  Widget _buildPastorDrawer() {
    return Drawer(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).padding.top + 24, 20, 24),
            decoration: const BoxDecoration(color: AppColors.navy, borderRadius: BorderRadius.only(bottomRight: Radius.circular(28))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(color: AppColors.gold, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
                  child: const Center(child: Icon(Icons.person, size: 34, color: AppColors.navy)),
                ),
                const SizedBox(height: 14),
                Text('Pastor Office', style: AppFonts.heading(size: 18, color: Colors.white)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                  child: Text(widget.branchName, style: AppFonts.body(size: 10, weight: FontWeight.w700, color: AppColors.gold)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                _drawerItem(
                  Icons.people,
                  'Branch Members Directory',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => BranchDirectoryScreen()));
                  },
                ),
                _drawerItem(
                  Icons.groups,
                  'Departments & Fellowships',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => DepartmentsFellowshipsScreen()));
                  },
                ),
                _drawerItem(
                  Icons.campaign,
                  'Branch Announcements',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => BranchAnnouncementsScreen()));
                  },
                ),
                _drawerItem(
                  Icons.receipt_long,
                  'Branch Financials',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => BranchFinancialsScreen()));
                  },
                ),
                const Divider(height: 24, indent: 24, endIndent: 24),
                _drawerItem(
                  Icons.logout,
                  'Logout',
                  color: Colors.redAccent,
                  onTap: () {
                    Navigator.pop(context); // Close drawer
                    Navigator.pop(context); // Back to Login
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String label, {Color? color, VoidCallback? onTap}) {
    final c = color ?? AppColors.navy;
    return ListTile(
      leading: Icon(icon, color: c, size: 22),
      title: Text(label, style: AppFonts.body(size: 14, weight: FontWeight.w500, color: color ?? AppColors.charcoal)),
      onTap: onTap ?? () => Navigator.pop(context),
      horizontalTitleGap: 8,
    );
  }
}