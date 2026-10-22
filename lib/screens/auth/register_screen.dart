import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_text_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _obscure = true;
  bool _agree = false;
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the Terms & Privacy Policy'), backgroundColor: Colors.redAccent),
      );
      return;
    }
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() => _loading = false);

    // Simulate successful registration
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Account created successfully! Please log in.'), backgroundColor: AppColors.green),
    );

    // Navigate to Login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ─── GRADIENT HEADER ──────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.navy, Color(0xFF0F1D33)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person_add_alt_1_rounded, color: AppColors.gold, size: 40),
                  ),
                  const SizedBox(height: 16),
                  Text('Join Your Church', style: AppFonts.heading(size: 28, color: Colors.white)),
                  const SizedBox(height: 6),
                  Text('Create your ChApp account today', style: AppFonts.body(size: 14, color: Colors.white.withOpacity(0.7))),
                ],
              ),
            ),

            // ─── FORM ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(28),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Personal Info Section
                    Text('Personal Information', style: AppFonts.heading(size: 16, color: AppColors.navy)),
                    const SizedBox(height: 12),

                    _label('Full Name'),
                    AppTextField(
                      controller: _nameCtrl,
                      hint: 'Your full name',
                      icon: Icons.person_outline,
                      validator: (v) => v == null || v.trim().isEmpty ? 'Please enter your name' : null,
                    ),
                    const SizedBox(height: 16),

                    _label('Email Address'),
                    AppTextField(
                      controller: _emailCtrl,
                      hint: 'you@church.org',
                      icon: Icons.mail_outline,
                      keyboard: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Please enter your email';
                        final regex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$');
                        if (!regex.hasMatch(v.trim())) return 'Please enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // M-Pesa Section
                    Row(
                      children: [
                        Text('Payment Setup', style: AppFonts.heading(size: 16, color: AppColors.navy)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: AppColors.green.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                          child: Text('M-Pesa', style: AppFonts.body(size: 10, weight: FontWeight.w700, color: AppColors.green)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Used to send payment prompts (STK Push) directly to your phone.', style: AppFonts.body(size: 12, color: AppColors.slate)),
                    const SizedBox(height: 12),

                    _label('M-Pesa Phone Number'),
                    AppTextField(
                      controller: _phoneCtrl,
                      hint: '07XX XXX XXX',
                      icon: Icons.phone_android_outlined,
                      keyboard: TextInputType.phone,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Please enter your phone number';
                        final digits = v.replaceAll(RegExp(r'[^0-9]'), '');
                        if (digits.length < 9) return 'Enter a valid Safaricom number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Security Section
                    Text('Security', style: AppFonts.heading(size: 16, color: AppColors.navy)),
                    const SizedBox(height: 12),

                    _label('Password'),
                    AppTextField(
                      controller: _passCtrl,
                      hint: 'At least 6 characters',
                      icon: Icons.lock_outline,
                      obscure: _obscure,
                      suffix: IconButton(
                        icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.slate, size: 20),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please enter a password';
                        if (v.length < 6) return 'Password must be at least 6 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    _label('Confirm Password'),
                    AppTextField(
                      controller: _confirmCtrl,
                      hint: 'Repeat your password',
                      icon: Icons.lock_outline,
                      obscure: _obscure,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please confirm your password';
                        if (v != _passCtrl.text) return 'Passwords do not match';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // Terms Checkbox
                    Row(
                      children: [
                        SizedBox(
                          width: 22,
                          height: 22,
                          child: Checkbox(
                            value: _agree,
                            onChanged: (v) => setState(() => _agree = v ?? false),
                            activeColor: AppColors.navy,
                            side: BorderSide(color: AppColors.slate.withOpacity(0.5), width: 1.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: AppFonts.body(size: 13, color: AppColors.slate),
                              children: const [
                                TextSpan(text: 'I agree to the '),
                                TextSpan(text: 'Terms', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.navy)),
                                TextSpan(text: ' & '),
                                TextSpan(text: 'Privacy Policy', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.navy)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Submit Button
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          foregroundColor: AppColors.navy,
                          elevation: 0,
                          disabledBackgroundColor: AppColors.gold.withOpacity(0.6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: _loading
                            ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: AppColors.navy, strokeWidth: 2.5))
                            : Text('Create Account', style: AppFonts.body(size: 16, weight: FontWeight.w700, color: AppColors.navy)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login Link
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Already have an account? ', style: AppFonts.body(size: 13, color: AppColors.slate)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginScreen()),
                              );
                            },
                            child: Text('Log in', style: AppFonts.body(size: 13, weight: FontWeight.w700, color: AppColors.gold)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: AppFonts.body(size: 13, weight: FontWeight.w600, color: AppColors.navy),
    ),
  );
}