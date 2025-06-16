import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/about_us.dart';
import 'package:tuneyverse/pages/contact%20page.dart';
import 'package:tuneyverse/pages/homepage.dart';
import 'package:tuneyverse/pages/login_page.dart';
import 'package:tuneyverse/pages/pricing_page.dart';
import 'package:tuneyverse/pages/signup.dart';
import 'package:tuneyverse/pages/widgets/features/features.dart';
import 'package:tuneyverse/pages/widgets/features/manual.dart';
import 'package:tuneyverse/pages/widgets/features/song_instrumental/hero_section.dart';
import 'package:tuneyverse/pages/widgets/features/song_instrumental/sound_q.dart';
import 'package:tuneyverse/pages/widgets/header.dart';
import 'package:tuneyverse/pages/widgets/footer.dart';
import 'package:tuneyverse/pages/widgets/pricing_sectiont.dart';

class SongInstrumental extends StatelessWidget {
  const SongInstrumental({super.key});

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
            onPricing: () {
              Navigator.of(context).push(
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
                SongInstrumentalWidget(),
                SoundQuality(),
                FeaturesSection(),
                ManualStepsWidget(),
                PricingSection(),             
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
    home: SongInstrumental(),
  ));
}