import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AdminBroadcastTab extends StatefulWidget {
  const AdminBroadcastTab({super.key});

  @override
  State<AdminBroadcastTab> createState() => _AdminBroadcastTabState();
}

class _AdminBroadcastTabState extends State<AdminBroadcastTab> {
  // Form State
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  String _targetAudience = 'All Church Members';
  String _deliveryMethod = 'Push Notification';
  bool _isScheduled = false;
  bool _sending = false;

  // Mock Active Broadcasts
  final List<Map<String, dynamic>> _activeBroadcasts = [
    {
      'title': 'Sunday Service Update',
      'preview': 'Join us this Sunday at 9 AM for a powerful message on Faith.',
      'audience': 'All Church Members',
      'date': 'Sent: Today, 8:30 AM',
      'status': 'Sent',
      'icon': Icons.campaign,
      'color': AppColors.green,
    },
    {
      'title': 'Youth Camp Registration',
      'preview': 'Registration for the annual youth camp is now open. Limited slots!',
      'audience': 'Youth Fellowship',
      'date': 'Scheduled: Oct 25, 2026',
      'status': 'Scheduled',
      'icon': Icons.schedule,
      'color': Colors.orange,
    },
    {
      'title': 'Building Fund Update',
      'preview': 'We are 65% towards our goal! Thank you for giving generously.',
      'audience': 'Department Heads',
      'date': 'Sent: Oct 12, 2026',
      'status': 'Archived',
      'icon': Icons.archive,
      'color': AppColors.slate,
    },
  ];

  @override
  void dispose() {
    _titleCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  void _sendBroadcast() {
    if (_titleCtrl.text.isEmpty || _bodyCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both title and message.'), backgroundColor: Colors.redAccent),
      );
      return;
    }

    setState(() => _sending = true);

    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _activeBroadcasts.insert(0, {
          'title': _titleCtrl.text,
          'preview': _bodyCtrl.text,
          'audience': _targetAudience,
          'date': _isScheduled ? 'Scheduled: Tomorrow, 9:00 AM' : 'Sent: Just now',
          'status': _isScheduled ? 'Scheduled' : 'Sent',
          'icon': _isScheduled ? Icons.schedule : Icons.check_circle,
          'color': _isScheduled ? Colors.orange : AppColors.green,
        });
        _titleCtrl.clear();
        _bodyCtrl.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isScheduled ? 'Broadcast Scheduled successfully!' : 'Broadcast Sent successfully!'),
          backgroundColor: AppColors.green,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Broadcast Center', style: AppFonts.heading(size: 22, color: AppColors.navy)),
          const SizedBox(height: 4),
          Text('Send urgent alerts, push notifications, or SMS to your congregation.', style: AppFonts.body(size: 13, color: AppColors.slate)),
          const SizedBox(height: 20),

          // ─── COMPOSE SECTION ──────────────────────────────
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.slate.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('New Broadcast', style: AppFonts.heading(size: 16, color: AppColors.navy)),
                const SizedBox(height: 16),

                // Title
                TextField(
                  controller: _titleCtrl,
                  style: AppFonts.body(size: 15),
                  decoration: _inputDecoration('Broadcast Title (e.g., Sunday Service Update)'),
                ),
                const SizedBox(height: 12),

                // Body
                TextField(
                  controller: _bodyCtrl,
                  maxLines: 4,
                  style: AppFonts.body(size: 15),
                  decoration: _inputDecoration('Type your message here...'),
                ),
                const SizedBox(height: 12),

                // Audience Dropdown
                DropdownButtonFormField<String>(
                  value: _targetAudience,
                  decoration: _dropdownDecoration('Target Audience'),
                  items: ['All Church Members', 'Specific Branch', 'Department Heads', 'Youth Fellowship', 'Treasurers / Leaders']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => setState(() => _targetAudience = v!),
                ),
                const SizedBox(height: 12),

                // Delivery Method
                Row(
                  children: [
                    Expanded(
                      child: _deliveryOption('Push', Icons.notifications_active, _deliveryMethod == 'Push Notification', () => setState(() => _deliveryMethod = 'Push Notification')),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _deliveryOption('SMS', Icons.sms, _deliveryMethod == 'SMS Broadcast', () => setState(() => _deliveryMethod = 'SMS Broadcast')),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _deliveryOption('In-App', Icons.app_registration, _deliveryMethod == 'In-App Notice', () => setState(() => _deliveryMethod = 'In-App Notice')),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Schedule Toggle
                Row(
                  children: [
                    SizedBox(
                      width: 22,
                      height: 22,
                      child: Checkbox(
                        value: _isScheduled,
                        onChanged: (v) => setState(() => _isScheduled = v ?? false),
                        activeColor: AppColors.navy,
                        side: BorderSide(color: AppColors.slate.withOpacity(0.5), width: 1.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('Schedule for later (Tomorrow, 9:00 AM)', style: AppFonts.body(size: 13, color: AppColors.slate)),
                  ],
                ),
                const SizedBox(height: 20),

                // Send Button
                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _sending ? null : _sendBroadcast,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: AppColors.navy,
                      disabledBackgroundColor: AppColors.gold.withOpacity(0.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    child: _sending
                        ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: AppColors.navy, strokeWidth: 2.5))
                        : Text(_isScheduled ? 'Schedule Broadcast' : 'Publish Broadcast', style: AppFonts.body(size: 16, weight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // ─── ACTIVE BROADCASTS FEED ──────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Broadcast History', style: AppFonts.heading(size: 18, color: AppColors.navy)),
              Text('${_activeBroadcasts.length} Total', style: AppFonts.body(size: 12, weight: FontWeight.w600, color: AppColors.slate)),
            ],
          ),
          const SizedBox(height: 12),

          ..._activeBroadcasts.map((b) => _broadcastCard(b)).toList(),
        ],
      ),
    );
  }

  // --- HELPERS ---

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppFonts.body(size: 14, color: AppColors.slate),
      filled: true,
      fillColor: AppColors.cream,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: AppFonts.body(size: 13, color: AppColors.slate),
      filled: true,
      fillColor: AppColors.cream,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    );
  }

  Widget _deliveryOption(String label, IconData icon, bool active, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: active ? AppColors.navy : AppColors.cream,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: active ? AppColors.navy : AppColors.slate.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: active ? AppColors.gold : AppColors.slate),
            const SizedBox(height: 6),
            Text(label, style: AppFonts.body(size: 12, weight: FontWeight.w600, color: active ? Colors.white : AppColors.slate)),
          ],
        ),
      ),
    );
  }

  Widget _broadcastCard(Map<String, dynamic> b) {
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (b['color'] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(b['icon'] as IconData, size: 20, color: b['color'] as Color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(b['title'], style: AppFonts.body(size: 14, weight: FontWeight.w700)),
                    Text(b['audience'], style: AppFonts.body(size: 11, color: AppColors.slate)),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: (b['color'] as Color).withOpacity(0.12), borderRadius: BorderRadius.circular(6)),
                child: Text(b['status'], style: AppFonts.body(size: 10, weight: FontWeight.w700, color: b['color'] as Color)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(b['preview'], style: AppFonts.body(size: 13, color: AppColors.charcoal, height: 1.4), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(b['date'], style: AppFonts.body(size: 11, color: AppColors.slate)),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 18, color: AppColors.navy),
                    onPressed: () {},
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.archive_outlined, size: 18, color: Colors.redAccent),
                    onPressed: () {
                      setState(() => _activeBroadcasts.remove(b));
                    },
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}