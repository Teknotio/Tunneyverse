import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/login_page.dart';
import 'package:tuneyverse/pages/signup.dart';
import 'package:tuneyverse/pages/widgets/features/candi.dart';
import 'package:tuneyverse/pages/widgets/features/features.dart';
import 'package:tuneyverse/pages/widgets/features/manual.dart';
import 'package:tuneyverse/pages/widgets/features/sound_quality.dart';
import 'package:tuneyverse/pages/widgets/header.dart';
import 'package:tuneyverse/pages/widgets/footer.dart';
import 'package:tuneyverse/pages/widgets/pricing_sectiont.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

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
                ChorusAndInstrumentalWidget(),
                SoundQualityWidget(),
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
    home: FeaturesPage(),
  ));
}