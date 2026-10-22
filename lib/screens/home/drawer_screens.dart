import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

// ---------------------------------------------------------
// 1. PROFILE SCREEN (Editable + Group Selection)
// ---------------------------------------------------------
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameCtrl = TextEditingController(text: 'John Mwangi');
  final _phoneCtrl = TextEditingController(text: '0712345678');

  String _selectedBranch = 'AIC — Central Branch';
  String? _selectedDepartment;
  String? _selectedFellowship;

  final List<String> _branches = [
    'AIC — Central Branch',
    'AIC — Westlands',
    'AIC — Eastleigh',
    'AIC — Karen',
  ];

  final List<String> _departments = [
    'Choir & Worship',
    'Ushering',
    'Youth Ministry',
    'Sunday School',
    'Media & Tech',
    'Intercessory Prayer',
  ];

  final List<String> _fellowships = [
    'Men’s Fellowship',
    'Women’s Fellowship',
    'Youth Fellowship',
    'Young Adults',
    'Couples Fellowship',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  void _saveProfile() {
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: AppColors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Profile & Account',
            style: AppFonts.heading(size: 20, color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: AppColors.gold),
            onPressed: _saveProfile,
            tooltip: 'Save Changes',
          ),
        ],
      ),
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.gold,
                    child: Icon(Icons.person, size: 50, color: AppColors.navy),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.navy,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt,
                        size: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text('Personal Information',
                style: AppFonts.heading(size: 18, color: AppColors.navy)),
            const SizedBox(height: 12),
            _buildTextField('Full Name', _nameCtrl, Icons.person_outline),
            const SizedBox(height: 12),
            _buildTextField('Phone Number', _phoneCtrl, Icons.phone_outlined,
                isPhone: true),

            const SizedBox(height: 28),

            Text('Church Connections',
                style: AppFonts.heading(size: 18, color: AppColors.navy)),
            const SizedBox(height: 4),
            Text('Join a branch, department, or fellowship group.',
                style: AppFonts.body(size: 13, color: AppColors.slate)),
            const SizedBox(height: 16),

            _buildDropdown(
              label: 'Church Branch',
              icon: Icons.location_city_outlined,
              value: _selectedBranch,
              items: _branches,
              onChanged: (val) => setState(() => _selectedBranch = val!),
            ),
            const SizedBox(height: 16),

            _buildDropdown(
              label: 'Join a Department',
              icon: Icons.groups_2_outlined,
              value: _selectedDepartment,
              items: _departments,
              onChanged: (val) => setState(() => _selectedDepartment = val),
            ),
            const SizedBox(height: 16),

            _buildDropdown(
              label: 'Join a Fellowship Group',
              icon: Icons.handshake_outlined,
              value: _selectedFellowship,
              items: _fellowships,
              onChanged: (val) => setState(() => _selectedFellowship = val),
            ),

            const SizedBox(height: 40),

            SizedBox(
              height: 54,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.navy,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Save Changes',
                  style: AppFonts.body(size: 16, weight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      {bool isPhone = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppFonts.body(
                size: 13, weight: FontWeight.w600, color: AppColors.slate)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
          style: AppFonts.body(size: 15),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.navy, size: 20),
            filled: true,
            fillColor: AppColors.white,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.slate.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.slate.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.navy, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppFonts.body(
                size: 13, weight: FontWeight.w600, color: AppColors.slate)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.slate),
          style: AppFonts.body(size: 15, color: AppColors.charcoal),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.navy, size: 20),
            filled: true,
            fillColor: AppColors.white,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.slate.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.slate.withOpacity(0.2)),
            ),
          ),
          hint: Text('Select $label',
              style: AppFonts.body(size: 15, color: AppColors.slate)),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// 2. CONTRIBUTION HISTORY SCREEN (With Filters)
// ---------------------------------------------------------
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _allTransactions = [
    {
      'category': 'Tithe',
      'date': 'Oct 15, 2026',
      'amount': 5000,
      'mpesa': 'QGH7X8Y2LK',
      'icon': Icons.church,
      'color': AppColors.gold,
    },
    {
      'category': 'Offering',
      'date': 'Oct 12, 2026',
      'amount': 2500,
      'mpesa': 'QGH4P3M1NB',
      'icon': Icons.volunteer_activism,
      'color': AppColors.green,
    },
    {
      'category': 'Thanksgiving',
      'date': 'Oct 8, 2026',
      'amount': 5000,
      'mpesa': 'QGH2W9C5KD',
      'icon': Icons.celebration,
      'color': AppColors.navy,
    },
    {
      'category': 'Tithe',
      'date': 'Sep 14, 2026',
      'amount': 4500,
      'mpesa': 'QGF9K2L8MN',
      'icon': Icons.church,
      'color': AppColors.gold,
    },
    {
      'category': 'Offering',
      'date': 'Sep 10, 2026',
      'amount': 1000,
      'mpesa': 'QGF1B7N4VX',
      'icon': Icons.volunteer_activism,
      'color': AppColors.green,
    },
    {
      'category': 'Tithe',
      'date': 'Aug 12, 2026',
      'amount': 5000,
      'mpesa': 'QGE7C2X9PZ',
      'icon': Icons.church,
      'color': AppColors.gold,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredList = _selectedFilter == 'All'
        ? _allTransactions
        : _allTransactions
        .where((t) => t['category'] == _selectedFilter)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Contribution History',
            style: AppFonts.heading(size: 20, color: Colors.white)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: AppColors.navy,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Given (This Year)',
                      style: AppFonts.body(
                        size: 13,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'KES 23,000',
                      style: AppFonts.heading(
                        size: 28,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '2026',
                    style: AppFonts.body(
                      size: 13,
                      weight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All', 'Tithe', 'Offering', 'Thanksgiving']
                    .map((filter) => _filterChip(filter))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: filteredList.isEmpty
                ? Center(
              child: Text(
                'No ${_selectedFilter.toLowerCase()}s found.',
                style: AppFonts.body(color: AppColors.slate),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 32),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final tx = filteredList[index];
                return _transactionTile(tx);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label) {
    final active = _selectedFilter == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(
          label,
          style: AppFonts.body(
            size: 13,
            weight: active ? FontWeight.w700 : FontWeight.w500,
            color: active ? AppColors.navy : AppColors.slate,
          ),
        ),
        selected: active,
        onSelected: (val) {
          if (val) setState(() => _selectedFilter = label);
        },
        selectedColor: AppColors.gold,
        backgroundColor: AppColors.white,
        side: BorderSide(
          color: active ? AppColors.gold : AppColors.slate.withOpacity(0.2),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _transactionTile(Map<String, dynamic> tx) {
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
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: (tx['color'] as Color).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              tx['icon'] as IconData,
              color: tx['color'] as Color,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx['category'],
                  style: AppFonts.body(
                    size: 14,
                    weight: FontWeight.w700,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${tx['date']} · ${tx['mpesa']}',
                  style: AppFonts.body(size: 12, color: AppColors.slate),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'KES ${(tx['amount'] as int)}',
                style: AppFonts.body(
                  size: 14,
                  weight: FontWeight.w700,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Success',
                  style: AppFonts.body(
                    size: 9,
                    weight: FontWeight.w700,
                    color: AppColors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 3. RECEIPTS SCREEN
// ---------------------------------------------------------
class ReceiptsScreen extends StatelessWidget {
  const ReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final receipts = [
      {'title': 'Tithe Receipt', 'date': 'Oct 15, 2026', 'amount': 'KES 5,000'},
      {'title': 'Offering Receipt', 'date': 'Oct 12, 2026', 'amount': 'KES 2,500'},
      {'title': 'Thanksgiving Receipt', 'date': 'Oct 8, 2026', 'amount': 'KES 5,000'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Download Receipts',
            style: AppFonts.heading(size: 20, color: Colors.white)),
      ),
      backgroundColor: AppColors.cream,
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: receipts.length,
        itemBuilder: (context, index) {
          final receipt = receipts[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.slate.withOpacity(0.1)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.navy.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.picture_as_pdf, color: AppColors.navy),
              ),
              title: Text(receipt['title']!,
                  style: AppFonts.body(size: 14, weight: FontWeight.w700)),
              subtitle: Text('${receipt['date']} · ${receipt['amount']}',
                  style: AppFonts.body(size: 12, color: AppColors.slate)),
              trailing: IconButton(
                icon: const Icon(Icons.download_rounded, color: AppColors.gold),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Downloading ${receipt['title']}...'),
                      backgroundColor: AppColors.green,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------
// 4. ANNOUNCEMENTS SCREEN
// ---------------------------------------------------------
class AnnouncementsScreen extends StatelessWidget {
  const AnnouncementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Announcements & Events',
            style: AppFonts.heading(size: 20, color: Colors.white)),
      ),
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Featured Event
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('FEATURED EVENT',
                        style: AppFonts.body(size: 10, weight: FontWeight.w700, color: AppColors.navy)),
                  ),
                  const SizedBox(height: 12),
                  Text('Annual Church Harvest',
                      style: AppFonts.heading(size: 22, color: Colors.white)),
                  const SizedBox(height: 6),
                  Text('Sunday, Nov 20, 2026 · 9:00 AM',
                      style: AppFonts.body(size: 13, color: Colors.white.withOpacity(0.8))),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text('Upcoming Events',
                style: AppFonts.heading(size: 18, color: AppColors.navy)),
            const SizedBox(height: 12),

            _eventItem('Youth Camp 2026', 'Dec 5 - Dec 8 · Camp Site', Icons.local_fire_department),
            _eventItem('Community Outreach', 'Nov 12 · 10:00 AM', Icons.volunteer_activism),
            _eventItem('Leaders Retreat', 'Nov 8 · 8:00 AM', Icons.groups),
          ],
        ),
      ),
    );
  }

  Widget _eventItem(String title, String subtitle, IconData icon) {
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.gold, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppFonts.body(size: 15, weight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: AppFonts.body(size: 13, color: AppColors.slate)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.slate),
        ],
      ),
    );
  }
}