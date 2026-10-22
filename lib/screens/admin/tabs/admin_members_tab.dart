import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AdminMembersTab extends StatefulWidget {
  const AdminMembersTab({super.key});

  @override
  State<AdminMembersTab> createState() => _AdminMembersTabState();
}

class _AdminMembersTabState extends State<AdminMembersTab> {
  final _searchCtrl = TextEditingController();

  // Mock database of approved members
  final List<Map<String, dynamic>> _members = [
    {
      'id': 'AIC-2026-0012',
      'name': 'John Mwangi',
      'email': 'member@gmail.com',
      'role': 'Member',
      'branch': 'AIC Central',
      'status': 'Active',
    },
    {
      'id': 'ICT-2026-0089',
      'name': 'Jane Wanjiru',
      'email': 'jane@gmail.com',
      'role': 'Head of ICT',
      'branch': 'AIC Westlands',
      'status': 'Active',
    },
    {
      'id': 'AIC-2026-0102',
      'name': 'Peter Kamau',
      'email': 'peter@gmail.com',
      'role': 'Member',
      'branch': 'AIC Central',
      'status': 'Active',
    },
  ];

  // Mock queue of pending members
  final List<Map<String, dynamic>> _pendingMembers = [
    {
      'name': 'Mary Atieno',
      'email': 'mary@gmail.com',
      'branch': 'AIC Karen',
      'date': 'Today, 10:15 AM',
    },
    {
      'name': 'David Ochieng',
      'email': 'david@gmail.com',
      'branch': 'AIC Central',
      'date': 'Yesterday, 4:30 PM',
    },
  ];

  List<Map<String, dynamic>> get _filteredMembers {
    final query = _searchCtrl.text.toLowerCase();
    if (query.isEmpty) return _members;
    return _members.where((m) =>
    m['name'].toString().toLowerCase().contains(query) ||
        m['email'].toString().toLowerCase().contains(query)
    ).toList();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.cream,
        appBar: AppBar(
          backgroundColor: AppColors.cream,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text('Member Directory', style: AppFonts.heading(size: 22, color: AppColors.navy)),
          bottom: TabBar(
            labelColor: AppColors.navy,
            unselectedLabelColor: AppColors.slate,
            indicatorColor: AppColors.gold,
            indicatorWeight: 3,
            labelStyle: AppFonts.body(size: 14, weight: FontWeight.w700),
            tabs: [
              const Tab(text: 'All Members'),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Pending Approvals'),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(10)),
                      child: Text('${_pendingMembers.length}', style: AppFonts.body(size: 10, weight: FontWeight.w700, color: Colors.white)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAllMembersTab(),
            _buildPendingTab(),
          ],
        ),
      ),
    );
  }

  // --- TAB 1: ALL MEMBERS ---
  Widget _buildAllMembersTab() {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
          child: TextField(
            controller: _searchCtrl,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search by name or email...',
              prefixIcon: const Icon(Icons.search, color: AppColors.slate),
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
        ),

        // List
        Expanded(
          child: _filteredMembers.isEmpty
              ? Center(child: Text('No members found.', style: AppFonts.body(color: AppColors.slate)))
              : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _filteredMembers.length,
            itemBuilder: (context, index) => _memberCard(_filteredMembers[index]),
          ),
        ),
      ],
    );
  }

  // --- TAB 2: PENDING MEMBERS ---
  Widget _buildPendingTab() {
    return _pendingMembers.isEmpty
        ? Center(child: Text('No pending approvals.', style: AppFonts.body(color: AppColors.slate)))
        : ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _pendingMembers.length,
      itemBuilder: (context, index) {
        final p = _pendingMembers[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.orange.withOpacity(0.1), child: const Icon(Icons.pending_actions, color: Colors.orange)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p['name'], style: AppFonts.body(size: 15, weight: FontWeight.w700)),
                        Text(p['email'], style: AppFonts.body(size: 12, color: AppColors.slate)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.orange.withOpacity(0.15), borderRadius: BorderRadius.circular(6)),
                    child: Text('Pending', style: AppFonts.body(size: 10, weight: FontWeight.w700, color: Colors.orange)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${p['branch']} · ${p['date']}', style: AppFonts.body(size: 11, color: AppColors.slate)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _pendingMembers.removeAt(index);
                          _members.insert(0, {
                            'id': 'AIC-2026-${1000 + DateTime.now().millisecond % 9000}',
                            'name': p['name'],
                            'email': p['email'],
                            'role': 'Member',
                            'branch': p['branch'],
                            'status': 'Active',
                          });
                        });
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Member approved!'), backgroundColor: AppColors.green));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: Colors.white),
                      child: const Text('Approve'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() => _pendingMembers.removeAt(index));
                      },
                      style: OutlinedButton.styleFrom(foregroundColor: Colors.redAccent, side: const BorderSide(color: Colors.redAccent)),
                      child: const Text('Reject'),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  // --- MEMBER CARD (For Tab 1) ---
  Widget _memberCard(Map<String, dynamic> member) {
    final isLeader = member['role'] != 'Member';
    final isActive = member['status'] == 'Active';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.slate.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: isLeader ? AppColors.gold.withOpacity(0.15) : AppColors.navy.withOpacity(0.05),
                child: Icon(Icons.person, color: isLeader ? AppColors.gold : AppColors.navy),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(member['name'], style: AppFonts.body(size: 15, weight: FontWeight.w700)),
                        if (isLeader) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, color: AppColors.gold, size: 16),
                        ]
                      ],
                    ),
                    Text(member['email'], style: AppFonts.body(size: 12, color: AppColors.slate)),
                  ],
                ),
              ),
              // Role Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isLeader ? AppColors.gold.withOpacity(0.15) : AppColors.navy.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  member['role'],
                  style: AppFonts.body(size: 10, weight: FontWeight.w700, color: isLeader ? AppColors.gold : AppColors.slate),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ID and Branch row
          Row(
            children: [
              const Icon(Icons.badge_outlined, size: 14, color: AppColors.slate),
              const SizedBox(width: 4),
              Text(member['id'], style: AppFonts.body(size: 12, weight: FontWeight.w600)),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: isActive ? AppColors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text(member['status'], style: AppFonts.body(size: 9, weight: FontWeight.w700, color: isActive ? AppColors.green : Colors.orange)),
              ),
              const Spacer(),
              const Icon(Icons.location_on_outlined, size: 14, color: AppColors.slate),
              const SizedBox(width: 4),
              Text(member['branch'], style: AppFonts.body(size: 12, color: AppColors.slate)),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 8),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showAssignRoleSheet(member),
                  icon: const Icon(Icons.admin_panel_settings, size: 16),
                  label: Text('Assign Role', style: AppFonts.body(size: 12, weight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.navy,
                    side: BorderSide(color: AppColors.slate.withOpacity(0.3)),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${member['id']} copied to clipboard!'), backgroundColor: AppColors.green),
                    );
                  },
                  icon: const Icon(Icons.copy, size: 16),
                  label: Text('Copy ID', style: AppFonts.body(size: 12, weight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.navy,
                    side: BorderSide(color: AppColors.slate.withOpacity(0.3)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- MODAL TO ASSIGN ROLE ---
  void _showAssignRoleSheet(Map<String, dynamic> member) {
    String? selectedRole = member['role'] == 'Member' ? 'Head of ICT' : member['role'];
    final customIdCtrl = TextEditingController(text: member['id']);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setState) => Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: Container(width: 44, height: 4, decoration: BoxDecoration(color: AppColors.slate.withOpacity(0.25), borderRadius: BorderRadius.circular(2)))),
                  const SizedBox(height: 16),
                  Text('Assign Role & ID', style: AppFonts.heading(size: 20, color: AppColors.navy)),
                  const SizedBox(height: 8),
                  Text('Assigning leadership to ${member['name']}', style: AppFonts.body(size: 13, color: AppColors.slate)),
                  const SizedBox(height: 24),

                  // Role Dropdown
                  Text('Select Role', style: AppFonts.body(size: 13, weight: FontWeight.w600, color: AppColors.navy)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedRole,
                    decoration: InputDecoration(filled: true, fillColor: AppColors.cream, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)),
                    items: ['Head of ICT', 'Head of Ushering', 'Youth Leader', 'Treasurer', 'Pastor', 'Department Head', 'Member']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (v) => setState(() => selectedRole = v),
                  ),
                  const SizedBox(height: 16),

                  // Generated ID Field
                  Text('Generated Login ID', style: AppFonts.body(size: 13, weight: FontWeight.w600, color: AppColors.navy)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: customIdCtrl,
                    style: AppFonts.body(size: 16, weight: FontWeight.w700, color: AppColors.green),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.green.withOpacity(0.05),
                      prefixIcon: const Icon(Icons.key, color: AppColors.green),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.green.withOpacity(0.3))),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('This code will be used by the member to log in.', style: AppFonts.body(size: 11, color: AppColors.slate)),
                  const SizedBox(height: 24),

                  // Save Button
                  SizedBox(
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          member['role'] = selectedRole!;
                          member['id'] = customIdCtrl.text;
                        });
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Role assigned. ID: ${customIdCtrl.text}'), backgroundColor: AppColors.green),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.gold,
                        foregroundColor: AppColors.navy,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text('Save & Generate ID', style: AppFonts.body(size: 15, weight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}