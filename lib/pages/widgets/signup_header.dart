import 'package:flutter/material.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 800;
        return Container(
          width: double.infinity,
          height: isDesktop ? 92 : 64,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFD9DADC),
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 0 : 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo on the left
                Image.asset(
                  'assets/logo.png', // <-- put your logo asset path here
                  height: isDesktop ? 38 : 28,
                  width: isDesktop ? 38 : 28,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10), // Space between logo and text
                Text(
                  'Tuneyverse',
                  style: TextStyle(
                    color: const Color(0xFF170F49),
                    fontSize: isDesktop ? 28.15 : 20.0,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    height: 1.06,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
