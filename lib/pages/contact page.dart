import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/homepage.dart';
import 'package:tuneyverse/pages/login_page.dart';
import 'package:tuneyverse/pages/signup.dart';
import 'package:tuneyverse/pages/about_us.dart';
import 'package:tuneyverse/pages/pricing_page.dart';
import 'package:tuneyverse/pages/widgets/contact_us.dart';
import 'package:tuneyverse/pages/widgets/faq_section.dart';
import 'package:tuneyverse/pages/widgets/header.dart';
import 'package:tuneyverse/pages/widgets/footer.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFFA),
      endDrawer: AppDrawer(
        onHome: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        },
        onPricing: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PricingPage()),
          );
        },
        onAboutUs: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AboutUs()),
          );
        },
        onContactUs: () {
          // Already here; optionally show a snackbar or do nothing
        },
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
      body: Column(
        children: [
          ResponsiveHeader(
            onHome: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            },
            onPricing: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PricingPage()),
              );
            },
            onAboutUs: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutUs()),
              );
            },
            onContactUs: () {
              // Already here; optionally show a snackbar or do nothing
            },
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
                ContactUsSection(),
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
