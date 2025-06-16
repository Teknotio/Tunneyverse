import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 800) {
      return const _DesktopHero();
    } else {
      return const _MobileHero();
    }
  }
}

// DESKTOP HERO SECTION
class _DesktopHero extends StatelessWidget {
  const _DesktopHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 900,
      color: const Color(0xFFF0EFFA),
      padding: const EdgeInsets.symmetric(horizontal: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Row(
            children: [
              // LEFT CONTENT
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 488,
                        child: Text(
                          'Transform Your Music Experience with AI',
                          style: const TextStyle(
                            color: Color(0xFF50449A),
                            fontSize: 56,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: 488,
                        child: Text(
                          'Tuneyverse revolutionizes the way you create karaoke tracks by leveraging advanced AI technology. Upload your favorite songs and instantly generate custom tracks tailored to your needs.',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF50449A),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color(0xFF50449A), width: 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Try Now',
                              style: TextStyle(
                                color: Color(0xFF50449A),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // RIGHT IMAGES
              Expanded(
                child: HeroImageStack(
                  isDesktop: true,
                  leftImages: [
                    'assets/images/img4.png',
                    'assets/images/img5.png',
                    'assets/images/img6.png',
                  ],
                  rightImages: [
                    'assets/images/img1.png',
                    'assets/images/img2.png',
                    'assets/images/img3.png',
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

// MOBILE HERO SECTION
class _MobileHero extends StatelessWidget {
  const _MobileHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF0EFFA),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Text Content
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 335,
                  child: Text(
                    'Transform Your Music Experience with AI',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
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
                    'Tuneyverse revolutionizes the way you create karaoke tracks by leveraging advanced AI technology. Upload your favorite songs and instantly generate custom tracks tailored to your needs.',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF50449A),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: Colors.black, width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Learn More',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Bottom Images
          Center(
            child: HeroImageStack(
              isDesktop: false,
              leftImages: [
                'assets/images/img4.png',
                'assets/images/img5.png',
                'assets/images/img6.png',
              ],
              rightImages: [
                'assets/images/img1.png',
                'assets/images/img2.png',
                'assets/images/img3.png',
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

// The reusable widget for the stacked images
class HeroImageStack extends StatelessWidget {
  final bool isDesktop;
  final List<String> leftImages;  // Provide 3 image paths
  final List<String> rightImages; // Provide 3 image paths

  const HeroImageStack({
    super.key,
    required this.isDesktop,
    required this.leftImages,
    required this.rightImages,
  });

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      // Desktop: two columns of 3 images each, stacked & slightly offset
      return SizedBox(
        width: double.infinity,
        height: 900,
        child: Stack(
          children: [
            Positioned(
              left: 291.57,
              top: 0,
              child: SizedBox(
                width: 276.43,
                child: Column(
                  children: leftImages.map((img) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      width: 276.43,
                      height: 294.39,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: img.startsWith('http')
                              ? NetworkImage(img)
                              : AssetImage(img) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: -152,
              child: SizedBox(
                width: 276.43,
                child: Column(
                  children: rightImages.map((img) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Container(
                      width: 276.43,
                      height: 294.39,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: img.startsWith('http')
                              ? NetworkImage(img)
                              : AssetImage(img) as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Mobile: two columns of 3 images each, stacked & slightly offset
      return SizedBox(
        width: 335,
        height: 460.31,
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Positioned(
              left: 176,
              top: -1.84,
              child: Column(
                children: leftImages.map((img) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    width: 160,
                    height: 170,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: img.startsWith('http')
                            ? NetworkImage(img)
                            : AssetImage(img) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
            Positioned(
              left: 0,
              top: -77.74,
              child: Column(
                children: rightImages.map((img) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    width: 160,
                    height: 170,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: img.startsWith('http')
                            ? NetworkImage(img)
                            : AssetImage(img) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      );
    }
  }
}
