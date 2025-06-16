import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/contact%20page.dart';
import 'package:tuneyverse/pages/homepage.dart';
import 'package:tuneyverse/pages/login_page.dart';
import 'package:tuneyverse/pages/pricing_page.dart';
import 'package:tuneyverse/pages/signup.dart';
import 'package:tuneyverse/pages/widgets/about%20us/hero.dart';
import 'package:tuneyverse/pages/widgets/about%20us/mission_vision.dart';
import 'package:tuneyverse/pages/widgets/about%20us/sec_text.dart';
import 'package:tuneyverse/pages/widgets/about%20us/why_choose.dart';
import 'package:tuneyverse/pages/widgets/contact_us.dart';
import 'package:tuneyverse/pages/widgets/header.dart';
import 'package:tuneyverse/pages/widgets/footer.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
          // Already here; you may show a snackbar if needed
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
            onAboutUs: () {
              // Already here; maybe show a snackbar ("You're here!") if needed
            },
            onContactUs: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ContactPage()),
              );
            },
            onPricing: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PricingPage()),
              );
            },
            onHome: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            },
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                AboutUsHeroSection(),
                AboutUsTextSection(),
                MissionVisionSection(),
                WhyChooseSection(),
                ContactUsSection(),            
                ResponsiveFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
