import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/contact%20page.dart';
import 'package:tuneyverse/pages/login_page.dart';
import 'package:tuneyverse/pages/pricing_page.dart';
import 'package:tuneyverse/pages/signup.dart';
import 'package:tuneyverse/pages/about_us.dart';
import 'package:tuneyverse/pages/widgets/ai_section.dart';
import 'package:tuneyverse/pages/widgets/extract_section.dart';
import 'package:tuneyverse/pages/widgets/faq_section.dart';
import 'package:tuneyverse/pages/widgets/header.dart';
import 'package:tuneyverse/pages/widgets/footer.dart';
import 'package:tuneyverse/pages/widgets/hero_section.dart';
import 'package:tuneyverse/pages/widgets/innovative_section.dart';
import 'package:tuneyverse/pages/widgets/pricing_sectiont.dart';
import 'package:tuneyverse/pages/widgets/studio_section.dart';
import 'package:tuneyverse/pages/widgets/upload_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0EFFA),
      endDrawer: AppDrawer(
        onHome: () {
          // Do nothing or scroll to top
        },
        onPricing: () {
          Navigator.of(context).push(
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
      body: SafeArea(
        child: Column(
          children: [
            ResponsiveHeader(
              onHome: () {},
              onPricing: () {
                Navigator.of(context).push(
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
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  HeroSection(),
                  UploadSection(),
                  ExtractSection(),
                  StudioSection(),
                  AiWidgetSection(),
                  InnovativeSection(),
                  PricingSection(),
                  FAQSection(),
                  ResponsiveFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
