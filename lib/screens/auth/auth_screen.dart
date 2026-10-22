import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

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
              padding: const EdgeInsets.only(top: 70, bottom: 50),
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
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.gold.withOpacity(0.3), width: 2),
                    ),
                    child: const Icon(Icons.church, color: AppColors.gold, size: 44),
                  ),
                  const SizedBox(height: 20),
                  Text('Welcome to ChApp', style: AppFonts.heading(size: 30, color: Colors.white)),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Stay connected, give securely, and grow together in faith.',
                      textAlign: TextAlign.center,
                      style: AppFonts.body(size: 14, color: Colors.white.withOpacity(0.7), height: 1.5),
                    ),
                  ),
                ],
              ),
            ),

            // ─── ACTION CARDS ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Primary: Log In Card
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.slate.withOpacity(0.1)),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.navy,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.login_rounded, color: AppColors.gold, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Log In', style: AppFonts.body(size: 16, weight: FontWeight.w700, color: AppColors.navy)),
                                const SizedBox(height: 2),
                                Text('I already have an account', style: AppFonts.body(size: 12, color: AppColors.slate)),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.slate),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Secondary: Create Account Card
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterScreen()),
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.gold.withOpacity(0.4), width: 1.5),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.person_add_alt_1_rounded, color: AppColors.gold, size: 24),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Create Account', style: AppFonts.body(size: 16, weight: FontWeight.w700, color: AppColors.navy)),
                                const SizedBox(height: 2),
                                Text('New to ChApp? Join here', style: AppFonts.body(size: 12, color: AppColors.slate)),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.slate),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: AppColors.slate.withOpacity(0.3))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text('or continue with', style: AppFonts.caption()),
                      ),
                      Expanded(child: Divider(color: AppColors.slate.withOpacity(0.3))),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Social Buttons
                  Row(
                    children: [
                      Expanded(
                        child: _socialButton(icon: Icons.g_mobiledata_rounded, label: 'Google', onTap: () {}),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _socialButton(icon: Icons.apple, label: 'Apple', onTap: () {}),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Legal footer
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppFonts.caption(),
                        children: const [
                          TextSpan(text: 'By continuing you agree to our\n'),
                          TextSpan(text: 'Terms of Service', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w600)),
                          TextSpan(text: ' and '),
                          TextSpan(text: 'Privacy Policy', style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return SizedBox(
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.slate.withOpacity(0.3)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: AppColors.navy),
            const SizedBox(width: 8),
            Text(label, style: AppFonts.body(size: 14, weight: FontWeight.w600, color: AppColors.navy)),
          ],
        ),
      ),
    );
  }
}