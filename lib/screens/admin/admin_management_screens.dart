import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'widgets/admin_forms.dart'; // Imports the forms we built earlier

// ============================================================
// 1. BRANCH MANAGEMENT SCREEN
// ============================================================
class BranchManagementScreen extends StatefulWidget {
  const BranchManagementScreen({super.key});

  @override
  State<BranchManagementScreen> createState() => _BranchManagementScreenState();
}

class _BranchManagementScreenState extends State<BranchManagementScreen> {
  final List<Map<String, dynamic>> _branches = [
    {'name': 'AIC — Central Branch', 'location': 'Nairobi CBD', 'members': '850'},
    {'name': 'AIC — Westlands', 'location': 'Westlands', 'members': '320'},
    {'name': 'AIC — Karen', 'location': 'Karen', 'members': '170'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Branch Management', style: AppFonts.heading(size: 20, color: Colors.white)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _branches.length,
        itemBuilder: (context, index) {
          final b = _branches[index];
          return _managementCard(
            title: b['name'],
            subtitle: '${b['location']} · ${b['members']} Members',
            icon: Icons.location_city,
            onDelete: () => setState(() => _branches.removeAt(index)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddBranchForm(context),
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.navy,
        icon: const Icon(Icons.add),
        label: Text('Add Branch', style: AppFonts.body(weight: FontWeight.w700)),
      ),
    );
  }
}

// ============================================================
// 2. DEPARTMENT MANAGEMENT SCREEN
// ============================================================
class DepartmentManagementScreen extends StatefulWidget {
  const DepartmentManagementScreen({super.key});

  @override
  State<DepartmentManagementScreen> createState() => _DepartmentManagementScreenState();
}

class _DepartmentManagementScreenState extends State<DepartmentManagementScreen> {
  final List<Map<String, dynamic>> _departments = [
    {'name': 'Choir & Worship', 'leader': 'John Mwangi', 'members': '45'},
    {'name': 'Ushering', 'leader': 'Mary W.', 'members': '24'},
    {'name': 'Media & Tech', 'leader': 'Peter K.', 'members': '12'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Departments', style: AppFonts.heading(size: 20, color: Colors.white)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _departments.length,
        itemBuilder: (context, index) {
          final d = _departments[index];
          return _managementCard(
            title: d['name'],
            subtitle: 'Head: ${d['leader']} · ${d['members']} Members',
            icon: Icons.groups,
            onDelete: () => setState(() => _departments.removeAt(index)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showCreateDepartmentForm(context),
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.navy,
        icon: const Icon(Icons.add),
        label: Text('Create Dept', style: AppFonts.body(weight: FontWeight.w700)),
      ),
    );
  }
}

// ============================================================
// 3. FELLOWSHIP MANAGEMENT SCREEN
// ============================================================
class FellowshipManagementScreen extends StatefulWidget {
  const FellowshipManagementScreen({super.key});

  @override
  State<FellowshipManagementScreen> createState() => _FellowshipManagementScreenState();
}

class _FellowshipManagementScreenState extends State<FellowshipManagementScreen> {
  final List<Map<String, dynamic>> _fellowships = [
    {'name': 'Karen Home Cell', 'leader': 'Elder James', 'members': '18'},
    {'name': 'Men\'s Fellowship', 'leader': 'Deacon Paul', 'members': '65'},
    {'name': 'Youth Fellowship', 'leader': 'Sarah K.', 'members': '120'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Fellowships', style: AppFonts.heading(size: 20, color: Colors.white)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _fellowships.length,
        itemBuilder: (context, index) {
          final f = _fellowships[index];
          return _managementCard(
            title: f['name'],
            subtitle: 'Leader: ${f['leader']} · ${f['members']} Members',
            icon: Icons.handshake,
            onDelete: () => setState(() => _fellowships.removeAt(index)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showCreateFellowshipForm(context),
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.navy,
        icon: const Icon(Icons.add),
        label: Text('Create Fellowship', style: AppFonts.body(weight: FontWeight.w700)),
      ),
    );
  }
}

// ============================================================
// SHARED CARD WIDGET
// ============================================================
Widget _managementCard({
  required String title,
  required String subtitle,
  required IconData icon,
  required VoidCallback onDelete,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.slate.withOpacity(0.1)),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.gold, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppFonts.body(size: 15, weight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(subtitle, style: AppFonts.body(size: 12, color: AppColors.slate)),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: onDelete,
        ),
      ],
    ),
  );
}