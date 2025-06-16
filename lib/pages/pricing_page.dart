import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/about_us.dart';
import 'package:tuneyverse/pages/contact%20page.dart';
import 'package:tuneyverse/pages/homepage.dart';
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
      endDrawer: AppDrawer(
        onHome: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false,
          );
        },
        onPricing: () {
          // Already here; maybe show a snackbar if needed
        },
        onAboutUs: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AboutUs()),
          );
        },
        onContactUs: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ContactPage()),
          );
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
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const HomePage()),
                (route) => false,
              );
            },
            onPricing: () {
              // Do nothing; already here, or show a snackbar if needed.
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
            onContactUs: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ContactPage()),
              );
            },
            onAboutUs: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutUs()),
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

// MAIN (for testing, remove from production)
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PricingPage(),
  ));
}
