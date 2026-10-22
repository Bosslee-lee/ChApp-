import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

// ============================================================
// 1. ADD BRANCH FORM
// ============================================================
Future<void> showAddBranchForm(BuildContext context) async {
  final nameCtrl = TextEditingController();
  final locationCtrl = TextEditingController();

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(ctx).viewInsets.bottom,
      ),
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
              _handle(),
              const SizedBox(height: 16),
              Text('Add New Branch',
                  style: AppFonts.heading(size: 20, color: AppColors.navy)),
              const SizedBox(height: 8),
              Text('Register a new church branch in the system.',
                  style: AppFonts.body(size: 13, color: AppColors.slate)),
              const SizedBox(height: 24),
              _inputField('Branch Name', 'e.g. AIC — Ruaka', nameCtrl),
              const SizedBox(height: 12),
              _inputField('Location / District', 'e.g. Kiambu County', locationCtrl),
              const SizedBox(height: 24),
              _submitButton(ctx, 'Create Branch', () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Branch "${nameCtrl.text}" created!'),
                    backgroundColor: AppColors.green,
                  ),
                );
                Navigator.pop(ctx);
              }),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// 2. CREATE DEPARTMENT FORM
// ============================================================
Future<void> showCreateDepartmentForm(BuildContext context) async {
  final nameCtrl = TextEditingController();
  final leaderCtrl = TextEditingController();
  String? selectedBranch = 'AIC — Central Branch';

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(ctx).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _handle(),
                const SizedBox(height: 16),
                Text('Create Department',
                    style: AppFonts.heading(size: 20, color: AppColors.navy)),
                const SizedBox(height: 8),
                Text('Add a new department and assign an overseer.',
                    style: AppFonts.body(size: 13, color: AppColors.slate)),
                const SizedBox(height: 24),
                _inputField('Department Name', 'e.g. Media & Tech', nameCtrl),
                const SizedBox(height: 12),
                _inputField('Department Head / Leader', 'e.g. John Mwangi', leaderCtrl),
                const SizedBox(height: 12),
                _dropdownField(
                  label: 'Assign to Branch',
                  value: selectedBranch,
                  items: ['AIC — Central Branch', 'AIC — Westlands', 'AIC — Karen'],
                  onChanged: (v) => setState(() => selectedBranch = v),
                ),
                const SizedBox(height: 24),
                _submitButton(ctx, 'Create Department', () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Department "${nameCtrl.text}" created!'),
                      backgroundColor: AppColors.green,
                    ),
                  );
                  Navigator.pop(ctx);
                }),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// 3. CREATE FELLOWSHIP FORM
// ============================================================
Future<void> showCreateFellowshipForm(BuildContext context) async {
  final nameCtrl = TextEditingController();
  final leaderCtrl = TextEditingController();
  String? selectedType = 'Home Fellowship';

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(ctx).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _handle(),
                const SizedBox(height: 16),
                Text('Create Fellowship Group',
                    style: AppFonts.heading(size: 20, color: AppColors.navy)),
                const SizedBox(height: 8),
                Text('Set up a new cell or home fellowship group.',
                    style: AppFonts.body(size: 13, color: AppColors.slate)),
                const SizedBox(height: 24),
                _inputField('Fellowship Name', 'e.g. Karen Home Cell', nameCtrl),
                const SizedBox(height: 12),
                _inputField('Fellowship Leader', 'e.g. Mary Wanjiru', leaderCtrl),
                const SizedBox(height: 12),
                _dropdownField(
                  label: 'Type',
                  value: selectedType,
                  items: ['Home Fellowship', 'Men\'s Fellowship', 'Women\'s Fellowship', 'Youth Fellowship', 'Young Adults'],
                  onChanged: (v) => setState(() => selectedType = v),
                ),
                const SizedBox(height: 24),
                _submitButton(ctx, 'Create Fellowship', () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Fellowship "${nameCtrl.text}" created!'),
                      backgroundColor: AppColors.green,
                    ),
                  );
                  Navigator.pop(ctx);
                }),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// 4. POST ANNOUNCEMENT FORM
// ============================================================
Future<void> showPostAnnouncementForm(BuildContext context) async {
  final titleCtrl = TextEditingController();
  final bodyCtrl = TextEditingController();
  String? selectedAudience = 'All Church Members';

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(ctx).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        top: false,
        child: StatefulBuilder(
          builder: (context, setState) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _handle(),
                const SizedBox(height: 16),
                Text('Post Announcement',
                    style: AppFonts.heading(size: 20, color: AppColors.navy)),
                const SizedBox(height: 8),
                Text('Send a message to your church members.',
                    style: AppFonts.body(size: 13, color: AppColors.slate)),
                const SizedBox(height: 24),
                _inputField('Announcement Title', 'e.g. Sunday Service Update', titleCtrl),
                const SizedBox(height: 12),
                TextField(
                  controller: bodyCtrl,
                  maxLines: 4,
                  style: AppFonts.body(size: 15),
                  decoration: _inputDecoration('Write your message...'),
                ),
                const SizedBox(height: 12),
                _dropdownField(
                  label: 'Target Audience',
                  value: selectedAudience,
                  items: ['All Church Members', 'Specific Branch', 'Department Heads', 'Youth Fellowship'],
                  onChanged: (v) => setState(() => selectedAudience = v),
                ),
                const SizedBox(height: 24),
                _submitButton(ctx, 'Publish Announcement', () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Announcement published successfully!'),
                      backgroundColor: AppColors.green,
                    ),
                  );
                  Navigator.pop(ctx);
                }),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// SHARED HELPERS
// ============================================================
Widget _handle() {
  return Center(
    child: Container(
      width: 44,
      height: 4,
      decoration: BoxDecoration(
        color: AppColors.slate.withOpacity(0.25),
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  );
}

Widget _inputField(String label, String hint, TextEditingController ctrl) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppFonts.body(size: 13, weight: FontWeight.w600, color: AppColors.navy)),
      const SizedBox(height: 8),
      TextField(
        controller: ctrl,
        style: AppFonts.body(size: 15),
        decoration: _inputDecoration(hint),
      ),
    ],
  );
}

InputDecoration _inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: AppFonts.body(size: 14, color: AppColors.slate),
    filled: true,
    fillColor: AppColors.cream,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}

Widget _dropdownField({
  required String label,
  required String? value,
  required List<String> items,
  required void Function(String?) onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppFonts.body(size: 13, weight: FontWeight.w600, color: AppColors.navy)),
      const SizedBox(height: 8),
      DropdownButtonFormField<String>(
        value: value,
        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.slate),
        style: AppFonts.body(size: 15, color: AppColors.charcoal),
        decoration: _inputDecoration('Select $label'),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    ],
  );
}

Widget _submitButton(BuildContext ctx, String label, VoidCallback onTap) {
  return SizedBox(
    height: 54,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gold,
        foregroundColor: AppColors.navy,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(label, style: AppFonts.body(size: 15, weight: FontWeight.w700)),
    ),
  );
}