import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class StatementScreen extends StatefulWidget {
  const StatementScreen({super.key});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _transactions = [
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
  ];

  @override
  Widget build(BuildContext context) {
    final filteredList = _selectedFilter == 'All'
        ? _transactions
        : _transactions
            .where((t) => t['category'] == _selectedFilter)
            .toList();

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'My Statement',
          style: AppFonts.heading(size: 20, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Downloading PDF statement...'),
                  backgroundColor: AppColors.green,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ---- SUMMARY CARD ----
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
                      'Total Given (YTD)',
                      style: AppFonts.body(
                        size: 13,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'KES 18,000',
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

          // ---- FILTERS ----
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

          // ---- TRANSACTION LIST ----
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Text(
                      'No records found.',
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
                'KES ${(tx['amount'] as int).toString()}',
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