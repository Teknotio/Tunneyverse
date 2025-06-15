import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/login_page.dart';
import 'package:tuneyverse/pages/signup.dart';
import 'package:tuneyverse/pages/widgets/faq_section.dart';
import 'package:tuneyverse/pages/widgets/header.dart';
import 'package:tuneyverse/pages/widgets/footer.dart';
import 'package:tuneyverse/pages/widgets/pricing/customer_testimonials.dart';
import 'package:tuneyverse/pages/widgets/pricing/hero_section.dart';
import 'package:tuneyverse/pages/widgets/pricing_sectiont.dart';


class PricingPage extends StatelessWidget {
  const PricingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFFA),
      body: Column(
        children: [
          ResponsiveHeader(
            onLogin: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignInPage()),
              );
            },
            onSignUp: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignUpPage()),
              );
            },
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                PricingHeroSection(imageAsset: 'assets/images/select_image.png'),
                PricingSection(),
                CustomerTestimonialsSection(),
                FAQSection(),
                ResponsiveFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// MAIN
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PricingPage(),
  ));
}