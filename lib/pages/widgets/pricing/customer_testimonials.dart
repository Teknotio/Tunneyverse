import 'package:flutter/material.dart';

class CustomerTestimonialsSection extends StatelessWidget {
  const CustomerTestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 800) {
      return const _DesktopTestimonials();
    } else {
      return const _MobileTestimonials();
    }
  }
}

// Desktop view
class _DesktopTestimonials extends StatelessWidget {
  const _DesktopTestimonials();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1440,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 112),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Color(0xFF251F48),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Subtitle
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 768),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Customer Testimonials',
                      style: TextStyle(
                        color: Color(0xFFF0EFFA),
                        fontSize: 48,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Tuneyverse has transformed my karaoke experience completely!',
                      style: TextStyle(
                        color: Color(0xFFF0EFFA),
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _TestimonialCard(
                      quote:
                          'The AI karaoke tracks are incredible! I love how easy it is to create custom versions of my favorite songs.',
                      name: 'Jane Doe',
                      role: 'Vocal Coach, Music Academy',
                      assetPath: 'assets/images/select_image.png',
                    ),
                  ),
                  const SizedBox(width: 64),
                  Expanded(
                    child: _TestimonialCard(
                      quote:
                          'Tuneyverse makes it so simple to get the exact karaoke track I need for my performances. The quality is top-notch!',
                      name: 'John Smith',
                      role: 'Content Creator, YouTube',
                      assetPath: 'assets/images/select_image.png',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Mobile view
class _MobileTestimonials extends StatelessWidget {
  const _MobileTestimonials();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Color(0xFF251F48),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 768),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 335,
                      child: Text(
                        'Customer Testimonials',
                        style: TextStyle(
                          color: Color(0xFFF0EFFA),
                          fontSize: 36,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      width: 335,
                      child: Text(
                        'Tuneyverse has transformed my karaoke experience completely!',
                        style: TextStyle(
                          color: Color(0xFFF0EFFA),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              _MobileTestimonialCard(
                quote:
                    'The AI karaoke tracks are incredible! I love how easy it is to create custom versions of my favorite songs.',
                name: 'Jane Doe',
                role: 'Vocal Coach, Music Academy',
                assetPath: 'assets/images/innovate1.png',
              ),
              const SizedBox(height: 48),
              _MobileTestimonialCard(
                quote:
                    'Tuneyverse makes it so simple to get the exact karaoke track I need for my performances. The quality is top-notch!',
                name: 'John Smith',
                role: 'Content Creator, YouTube',
                assetPath: 'assets/images/innovate1.png',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Desktop testimonial card
class _TestimonialCard extends StatelessWidget {
  final String quote;
  final String name;
  final String role;
  final String assetPath;

  const _TestimonialCard({
    required this.quote,
    required this.name,
    required this.role,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 608,
          child: Text(
            '"$quote"',
            style: const TextStyle(
              color: Color(0xFFF0EFFA),
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(assetPath),
                  fit: BoxFit.cover,
                ),
                shape: const OvalBorder(),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFFF0EFFA),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                Text(
                  role,
                  style: const TextStyle(
                    color: Color(0xFFF0EFFA),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// Mobile testimonial card
class _MobileTestimonialCard extends StatelessWidget {
  final String quote;
  final String name;
  final String role;
  final String assetPath;

  const _MobileTestimonialCard({
    required this.quote,
    required this.name,
    required this.role,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 335,
          child: Text(
            '"$quote"',
            style: const TextStyle(
              color: Color(0xFFF0EFFA),
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage(assetPath),
                  fit: BoxFit.cover,
                ),
                shape: const OvalBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: const TextStyle(
                color: Color(0xFFF0EFFA),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
            Text(
              role,
              style: const TextStyle(
                color: Color(0xFFF0EFFA),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
