import 'package:flutter/material.dart';

class AboutUsHeroSection extends StatelessWidget {
  const AboutUsHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth > 800;

        // Set image size based on device
        final double imageWidth = isDesktop ? 600 : 280;
        final double imageHeight = isDesktop ? 200 : 120;

        return Container(
          width: double.infinity,
          height: isDesktop ? 510 : 290,
          color: const Color(0xFF251F48),
          alignment: Alignment.center,
          child: Center(
            child: Image.asset(
              'assets/hero_about.png', // <-- Your asset path here!
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
