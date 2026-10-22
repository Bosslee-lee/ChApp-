import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

// ============================================================
// PUBLIC ENTRY POINT
// ============================================================
Future<void> showGiveFlow(
  BuildContext context, {
  String phoneNumber = '0758511323',
  String memberName = 'John Mwangi',
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _GiveFlowSheet(
      phoneNumber: phoneNumber,
      memberName: memberName,
    ),
  );
}

// ============================================================
// CATEGORY MODEL
// ============================================================
class _GiveCategory {
  final String label;
  final IconData icon;
  final Color color;
  const _GiveCategory(this.label, this.icon, this.color);
}

const _categories = [
  _GiveCategory('Tithe', Icons.church, AppColors.gold),
  _GiveCategory('Offering', Icons.volunteer_activism, AppColors.green),
  _GiveCategory('Thanksgiving', Icons.celebration, AppColors.navy),
];

// ============================================================
// MAIN SHEET
// ============================================================
class _GiveFlowSheet extends StatefulWidget {
  final String phoneNumber;
  final String memberName;

  const _GiveFlowSheet({
    required this.phoneNumber,
    required this.memberName,
  });

  @override
  State<_GiveFlowSheet> createState() => _GiveFlowSheetState();
}

class _GiveFlowSheetState extends State<_GiveFlowSheet> {
  int _step = 0; // 0 = choose, 1 = amount, 2 = confirming, 3 = success
  _GiveCategory? _selected;
  final _amountCtrl = TextEditingController();

  // Normalize phone to M-Pesa format: 254XXXXXXXXX
  String get _normalizedPhone {
    final raw = widget.phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (raw.startsWith('0')) return '254${raw.substring(1)}';
    if (raw.startsWith('254')) return raw;
    if (raw.startsWith('7') || raw.startsWith('1')) return '254$raw';
    return raw;
  }

  // Pretty display: 0758 511 323
  String get _prettyPhone {
    final raw = widget.phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    if (raw.length == 10 && raw.startsWith('0')) {
      return '${raw.substring(0, 4)} ${raw.substring(4, 7)} ${raw.substring(7)}';
    }
    if (raw.length == 12 && raw.startsWith('254')) {
      return '0${raw.substring(3, 6)} ${raw.substring(6, 9)} ${raw.substring(9)}';
    }
    return widget.phoneNumber;
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  void _quickAdd(int v) {
    final current =
        int.tryParse(_amountCtrl.text.replaceAll(',', '')) ?? 0;
    _amountCtrl.text = (current + v).toString();
  }

  Future<void> _confirmGive() async {
    final raw = _amountCtrl.text.trim();
    if (raw.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter an amount'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }
    final amount = int.tryParse(raw);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid amount'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _step = 2);

    // ============================================================
    // REAL M-PESA STK PUSH - WIRE THIS LATER
    // ============================================================
    // Replace the delay below with:
    //
    // final res = await http.post(
    //   Uri.parse('https://your-backend.com/api/mpesa/stkpush'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({
    //     'phone': _normalizedPhone,   // 254758511323
    //     'amount': amount,
    //     'category': _selected!.label,
    //     'accountReference': 'ChApp-${_selected!.label}',
    //     'description': '${_selected!.label} from ${widget.memberName}',
    //   }),
    // );
    // ============================================================

    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _step = 3);
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPad),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          top: false,
          child: AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _handle(),
                  const SizedBox(height: 8),
                  if (_step <= 1) _stepHeader(),
                  if (_step == 0) _chooseStep(),
                  if (_step == 1) _amountStep(),
                  if (_step == 2) _confirmingStep(),
                  if (_step == 3) _successStep(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---- HANDLE ----
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

  // ---- STEP HEADER ----
  Widget _stepHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 16),
      child: Row(
        children: [
          _dot(0, 'Choose'),
          _line(0),
          _dot(1, 'Amount'),
          _line(1),
          _dot(2, 'Pay'),
        ],
      ),
    );
  }

  Widget _dot(int index, String label) {
    final active = _step >= index;
    return Column(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color:
                active ? AppColors.gold : AppColors.slate.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: AppFonts.body(
                size: 11,
                weight: FontWeight.w700,
                color: active ? AppColors.navy : AppColors.slate,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppFonts.body(
            size: 10,
            weight: FontWeight.w600,
            color: active ? AppColors.navy : AppColors.slate,
          ),
        ),
      ],
    );
  }

  Widget _line(int afterIndex) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        height: 2,
        color: _step > afterIndex
            ? AppColors.gold
            : AppColors.slate.withOpacity(0.15),
      ),
    );
  }

  // ============================================================
  // STEP 0 - CHOOSE CATEGORY
  // ============================================================
  Widget _chooseStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'What would you like to give?',
          style: AppFonts.heading(size: 20, color: AppColors.navy),
        ),
        const SizedBox(height: 16),
        ..._categories.map((c) {
          final selected = _selected == c;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => setState(() => _selected = c),
              borderRadius: BorderRadius.circular(14),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: selected ? AppColors.navy : AppColors.cream,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: selected
                        ? AppColors.navy
                        : AppColors.slate.withOpacity(0.15),
                    width: selected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: selected
                            ? AppColors.gold.withOpacity(0.2)
                            : c.color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        c.icon,
                        color: selected ? AppColors.gold : c.color,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        c.label,
                        style: AppFonts.body(
                          size: 15,
                          weight: FontWeight.w700,
                          color: selected
                              ? Colors.white
                              : AppColors.charcoal,
                        ),
                      ),
                    ),
                    Icon(
                      selected
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: selected
                          ? AppColors.gold
                          : AppColors.slate.withOpacity(0.4),
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        const SizedBox(height: 16),
        SizedBox(
          height: 54,
          child: ElevatedButton(
            onPressed:
                _selected == null ? null : () => setState(() => _step = 1),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.navy,
              disabledBackgroundColor: AppColors.gold.withOpacity(0.35),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'Continue',
              style: AppFonts.body(size: 15, weight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // STEP 1 - ENTER AMOUNT
  // ============================================================
  Widget _amountStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => setState(() => _step = 0),
              icon: const Icon(Icons.arrow_back, color: AppColors.navy),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 8),
            Text(
              'Enter amount',
              style: AppFonts.heading(size: 20, color: AppColors.navy),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _selected!.color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  Icon(_selected!.icon, size: 16, color: _selected!.color),
            ),
            const SizedBox(width: 8),
            Text(
              _selected!.label,
              style: AppFonts.body(
                size: 13,
                weight: FontWeight.w600,
                color: AppColors.slate,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _amountCtrl,
          keyboardType: TextInputType.number,
          autofocus: true,
          style: AppFonts.heading(size: 32, color: AppColors.navy),
          decoration: InputDecoration(
            hintText: '0',
            hintStyle: AppFonts.heading(
              size: 32,
              color: AppColors.slate.withOpacity(0.4),
            ),
            prefixText: 'KES  ',
            prefixStyle: AppFonts.body(
              size: 15,
              weight: FontWeight.w700,
              color: AppColors.slate,
            ),
            filled: true,
            fillColor: AppColors.cream,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [500, 1000, 5000, 10000]
              .map((v) => _quickChip('+$v', () => _quickAdd(v)))
              .toList(),
        ),
        const SizedBox(height: 16),
        _phoneBanner(),
        const SizedBox(height: 16),
        SizedBox(
          height: 54,
          child: ElevatedButton(
            onPressed: _confirmGive,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.navy,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone_android, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Pay via M-Pesa',
                  style: AppFonts.body(
                    size: 15,
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---- PHONE BANNER ----
  Widget _phoneBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.green.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.green.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.phone_android,
                color: AppColors.green, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'M-Pesa prompt will be sent to',
                  style: AppFonts.body(
                    size: 11,
                    color: AppColors.slate,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _prettyPhone,
                  style: AppFonts.body(
                    size: 15,
                    weight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.verified,
              color: AppColors.green, size: 18),
        ],
      ),
    );
  }

  Widget _quickChip(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.navy.withOpacity(0.06),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: AppFonts.body(
            size: 13,
            weight: FontWeight.w600,
            color: AppColors.navy,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // STEP 2 - CONFIRMING (STK PUSH)
  // ============================================================
  Widget _confirmingStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          const SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              color: AppColors.gold,
              strokeWidth: 4,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Sending M-Pesa request...',
            style: AppFonts.heading(size: 18, color: AppColors.navy),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.cream,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.phone_android,
                    color: AppColors.navy, size: 16),
                const SizedBox(width: 6),
                Text(
                  _prettyPhone,
                  style: AppFonts.body(
                    size: 14,
                    weight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Check your phone for a prompt from M-Pesa.\nEnter your PIN to confirm.',
            style: AppFonts.body(
              size: 13,
              color: AppColors.slate,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STEP 3 - SUCCESS
  // ============================================================
  Widget _successStep() {
    final amount = _amountCtrl.text;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.check_circle,
                  color: AppColors.green, size: 48),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Thank you for giving!',
            style: AppFonts.heading(size: 20, color: AppColors.navy),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Your ${_selected!.label.toLowerCase()} of KES $amount\nhas been received from $_prettyPhone.',
            style: AppFonts.body(
              size: 13,
              color: AppColors.slate,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'M-Pesa Ref: QGH${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
              style: AppFonts.body(
                size: 11,
                weight: FontWeight.w600,
                color: AppColors.green,
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 54,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.navy,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                'Done',
                style: AppFonts.body(
                  size: 15,
                  weight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}