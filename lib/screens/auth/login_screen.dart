import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/app_text_field.dart';
import '../home/member_home_screen.dart';
import '../admin/admin_dashboard_screen.dart';
import '../pastor/pastor_dashboard_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _memberIdCtrl = TextEditingController();

  bool _obscure = true;
  bool _remember = true;
  bool _loading = false;

  // ─── Hardcoded test accounts ───────────────────────────────
  static const _testAccounts = <String, String>{
    'member@gmail.com': 'member123',
    'admin2@gmail.com': 'admin123',
    'pastor@gmail.com': 'pastor123',
  };

  // ─── Valid Leader IDs (Mock) ───────────────────────────────
  static const _validLeaderIds = [
    'ICT-2026-4821',
    'TRE-2026-1104',
    'USH-2026-9920',
    'PST-2026-0001',
    'PAS-123-12',
  ];

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _memberIdCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _loading = false);

    final email = _emailCtrl.text.trim().toLowerCase();
    final password = _passCtrl.text;
    final memberId = _memberIdCtrl.text.trim().toUpperCase();

    // 1. Validate Email & Password
    if (_testAccounts[email] != password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // 2. Admin Login
    if (email == 'admin2@gmail.com') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signed in as Church Admin'),
          backgroundColor: AppColors.navy,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminDashboardScreen()),
      );
      return;
    }

    // 3. Pastor Login
    if (email == 'pastor@gmail.com') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signed in as Pastor of AIC Westlands'),
          backgroundColor: AppColors.gold,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PastorDashboardScreen(branchName: 'AIC — Westlands'), // const removed
        ),
      );
      return;
    }

    // 4. Member / Leader Login
    String role = 'member';
    if (memberId.isNotEmpty) {
      if (_validLeaderIds.contains(memberId)) {
        role = 'leader';
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Member ID. Please check with Admin.'),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }
    }

    // Navigate to Member Home
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(role == 'leader' ? 'Signed in as Leader' : 'Signed in as Member'),
        backgroundColor: role == 'leader' ? AppColors.gold : AppColors.green,
      ),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MemberHomeScreen(
          email: email,
          role: role,
          leaderCode: memberId.isNotEmpty ? memberId : null,
        ),
      ),
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
                    child: const Icon(Icons.church, color: AppColors.gold, size: 40),
                  ),
                  const SizedBox(height: 16),
                  Text('Welcome Back', style: AppFonts.heading(size: 28, color: Colors.white)),
                  const SizedBox(height: 6),
                  Text('Sign in to continue to ChApp', style: AppFonts.body(size: 14, color: Colors.white.withOpacity(0.7))),
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
                    // Email
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
                    const SizedBox(height: 18),

                    // Password
                    _label('Password'),
                    AppTextField(
                      controller: _passCtrl,
                      hint: 'Enter your password',
                      icon: Icons.lock_outline,
                      obscure: _obscure,
                      suffix: IconButton(
                        icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.slate, size: 20),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please enter your password';
                        if (v.length < 6) return 'Password must be at least 6 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    // Member ID
                    Row(
                      children: [
                        _label('Member ID'),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                          child: Text('Leaders Only', style: AppFonts.body(size: 10, weight: FontWeight.w700, color: AppColors.gold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('Leave blank if you are a normal member.', style: AppFonts.body(size: 12, color: AppColors.slate)),
                    const SizedBox(height: 8),
                    AppTextField(
                      controller: _memberIdCtrl,
                      hint: 'e.g. ICT-2026-4821',
                      icon: Icons.badge_outlined,
                    ),
                    const SizedBox(height: 16),

                    // Remember Me & Forgot Password
                    Row(
                      children: [
                        SizedBox(
                          width: 22,
                          height: 22,
                          child: Checkbox(
                            value: _remember,
                            onChanged: (v) => setState(() => _remember = v ?? false),
                            activeColor: AppColors.navy,
                            side: BorderSide(color: AppColors.slate.withOpacity(0.5), width: 1.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text('Remember me', style: AppFonts.body(size: 13, color: AppColors.slate)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Password reset coming next'), backgroundColor: AppColors.navy),
                            );
                          },
                          child: Text('Forgot password?', style: AppFonts.body(size: 13, weight: FontWeight.w600, color: AppColors.navy)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Sign In Button
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.navy,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          disabledBackgroundColor: AppColors.navy.withOpacity(0.6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: _loading
                            ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                            : Text('Sign In', style: AppFonts.body(size: 16, weight: FontWeight.w700, color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Sign Up Link
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Don't have an account? ", style: AppFonts.body(size: 13, color: AppColors.slate)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const RegisterScreen()),
                              );
                            },
                            child: Text('Sign up', style: AppFonts.body(size: 13, weight: FontWeight.w700, color: AppColors.gold)),
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

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: AppFonts.body(size: 13, weight: FontWeight.w600, color: AppColors.navy),
      ),
    );
  }
}