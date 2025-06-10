import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/signup.dart';


class _SignUpPrompt extends StatelessWidget {
  final bool isDesktop;
  const _SignUpPrompt({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SignUpPage()),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF6A6A6A),
              side: const BorderSide(
                width: 1,
                color: Color(0xFF878787),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              padding: EdgeInsets.symmetric(vertical: isDesktop ? 16 : 10),
              backgroundColor: Colors.white,
            ),
            child: Text(
              'SIGN UP FOR TUNEYVERSE',
              style: TextStyle(
                color: const Color(0xFF6A6A6A),
                fontSize: isDesktop ? 13 : 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
