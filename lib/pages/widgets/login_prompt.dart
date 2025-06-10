import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/login_page.dart';

class _LoginPrompt extends StatelessWidget {
  final bool isDesktop;
  const _LoginPrompt({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SignInPage()),
          );
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  color: const Color(0xFF303030),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: 'Login',
                style: TextStyle(
                  color: const Color(0xFF50449A),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
