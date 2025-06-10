import 'package:flutter/material.dart';

class AiWidgetSection extends StatelessWidget {
  const AiWidgetSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 800) {
      return const _DesktopAiWidgetSection();
    } else {
      return const _MobileAiWidgetSection();
    }
  }
}

// DESKTOP VIEW
class _DesktopAiWidgetSection extends StatelessWidget {
  const _DesktopAiWidgetSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 112),
      color: const Color(0xFFF0EFFA),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // IMAGE (from assets)
              Expanded(
                child: Container(
                  height: 563,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/img2.png"), // <-- your asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 80),
              // TEXT CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 528,
                      child: Text(
                        'Transform Your Karaoke Experience with AI-Generated Videos and Lyrics',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: 528,
                      child: Text(
                        'Our Karaoke Video Generation feature allows you to create stunning karaoke videos with synchronized lyrics effortlessly. Choose from various track options, including instrumental only or full songs, ensuring a professional and engaging singing experience.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MOBILE VIEW
class _MobileAiWidgetSection extends StatelessWidget {
  const _MobileAiWidgetSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
      color: const Color(0xFFF0EFFA),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 335,
                child: Text(
                  'Transform Your Karaoke Experience with AI-Generated Videos and Lyrics',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 1.20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 335,
                child: Text(
                  'Our Karaoke Video Generation feature allows you to create stunning karaoke videos with synchronized lyrics effortlessly. Choose from various track options, including instrumental only or full songs, ensuring a professional and engaging singing experience.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 348,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/img2.png"), // <-- your asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
