import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/widgets/footer.dart';
import 'package:tuneyverse/pages/widgets/header.dart';
import 'package:video_player/video_player.dart';

// HEADER AND FOOTER FROM PREVIOUS ANSWERS (import or copy here)

class TuneyverseLandingPage extends StatelessWidget {
  const TuneyverseLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Static header at the very top (NOT scrollable)
          const ResponsiveHeader(),
          // All scrollable content below
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const _LandingHeroSection(),
                const AboutSection(),
                const PackageSection(),
                const _FaqSection(),
                const ResponsiveFooter(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


// ================= HERO SECTION =====================
class _LandingHeroSection extends StatelessWidget {
  const _LandingHeroSection();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final double boxHeight = isMobile ? 56 : 60;
    final double fontSize = isMobile ? 16 : 20;
    final double boxFontSize = isMobile ? 18 : 22;
    final double headlineSize = isMobile ? 22 : 36;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Headline
        Padding(
          padding: EdgeInsets.only(top: isMobile ? 28 : 36, bottom: 2),
          child: Text(
            "Turn any song or video into karaoke by removing vocals while\nkeeping the instrumental and lyrics intact.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Color(0xFF50449A),
              fontSize: headlineSize,
              height: 1.18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 28, top: 0),
          child: Text(
            "Powered by advanced AI for crystal-clear karaoke tracks and lyric videos!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.67),
              fontSize: isMobile ? 13 : 18,
            ),
          ),
        ),
        Center(
          child: Container(
            width: isMobile ? double.infinity : 1200,
            margin: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 0, vertical: 0),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 10 : 32,
              vertical: isMobile ? 16 : 28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card Headline
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 8, bottom: 12),
                  child: Text(
                    "Select package & choose files",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      fontSize: isMobile ? 20 : 28,
                      color: Colors.black.withOpacity(0.90),
                    ),
                  ),
                ),
                // Paste file watermark
                Container(
                  height: isMobile ? 90 : 150,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    "Paste File Here",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: isMobile ? 28 : 48,
                      color: Colors.black.withOpacity(0.10),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                // Row with dropdown and button
                Padding(
                  padding: const EdgeInsets.only(bottom: 4, top: 16),
                  child: Row(
                    children: [
                      // Dropdown style imitation
                      Expanded(
                        child: Container(
                          height: boxHeight,
                          decoration: BoxDecoration(
                            color: Color(0xFF1B191C).withOpacity(0.08), // 8% opacity
                            borderRadius: BorderRadius.zero, // sharp edges
                            border: Border.all(color: Colors.transparent),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              // Green dot
                              Container(
                                width: 9,
                                height: 9,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFBAF95A),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Vocal and Instrumental",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1B191C),
                                    fontSize: fontSize,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFBAF95A),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.all(2.5),
                                child: const Icon(Icons.forum, size: 18, color: Color(0xFF222222)),
                              ),
                              const SizedBox(width: 8),
                              Icon(Icons.keyboard_arrow_down, color: Colors.grey[400], size: 28),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Select Files Button
                      Expanded(
                        child: SizedBox(
                          height: boxHeight,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6555B9), // CTA color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero, // sharp edges
                              ),
                              padding: EdgeInsets.zero,
                              elevation: 0,
                            ),
                            child: Text(
                              "Select Files",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                fontSize: fontSize,
                                color: Colors.white,
                              ),
                            ),
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
        Padding(
          padding: EdgeInsets.only(
              left: isMobile ? 12 : 100, top: 18, right: 0, bottom: 10),
          child: Text(
            "* By uploading a file, you agree to our Terms of Service.",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              fontSize: isMobile ? 14 : 18,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
        ),
      ],
    );
  }
}


// ============== ABOUT SECTION =======================

class VideoContainer extends StatefulWidget {
  final String assetPath;
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const VideoContainer({
    Key? key,
    required this.assetPath,
    required this.width,
    required this.height,
    required this.borderRadius,
  }) : super(key: key);

  @override
  _VideoContainerState createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.assetPath)
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: _controller.value.isInitialized
          ? SizedBox(
              width: widget.width,
              height: widget.height,
              child: VideoPlayer(_controller),
            )
          : Container(
              width: widget.width,
              height: widget.height,
              color: Colors.black12,
              child: const Center(child: CircularProgressIndicator()),
            ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1440,
      height: 1024,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Color(0xFFF0EFFA),
      ),
      child: Stack(
        children: [
          // Background oval
          Positioned(
            left: -164,
            top: -176,
            child: Container(
              width: 1204,
              height: 1105,
              decoration: const ShapeDecoration(
                color: Color(0xFF251F48),
                shape: OvalBorder(),
              ),
            ),
          ),
          // First large image
          Positioned(
            left: 1008,
            top: 195,
            child: Container(
              width: 385,
              height: 434,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(217),
                ),
              ),
              child: VideoContainer(
                assetPath: 'assets/videos/vid3.mp4',
                width: 385,
                height: 434,
                borderRadius: BorderRadius.circular(217),
              ),
            ),
          ),
          // Second image
          Positioned(
            left: 930,
            top: 536,
            child: Container(
              width: 400,
              height: 350,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(72),
                ),
              ),
              child: VideoContainer(
                assetPath: 'assets/videos/vid2.mp4',
                width: 315,
                height: 351,
                borderRadius: BorderRadius.circular(112),
              ),
            ),
          ),
          // Third image (video)
          Positioned(
            left: 775,
            top: 330,
            child: Container(
              width: 315,
              height: 351,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(112),
                ),
              ),
              child: VideoContainer(
                assetPath: 'assets/videos/vid1.mp4',
                width: 315,
                height: 351,
                borderRadius: BorderRadius.circular(112),
              ),
            ),
          ),
          // Heading
          Positioned(
            left: 106,
            top: 133,
            child: Text(
              'What is Wasa?',
              style: TextStyle(
                color: const Color(0xFFE9E6F8),
                fontSize: 70,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 0.63,
              ),
            ),
          ),
          // Subheading/description
          Positioned(
            left: 106,
            top: 232,
            child: SizedBox(
              width: 498,
              height: 253,
              child: Text(
                "At The Wasa’s App, we’re redefining the karaoke and music practice experience. Using advanced AI, we empower users to transform any song or video into a fully customizable karaoke track by removing vocals, preserving instrumentals, and syncing lyrics with precision.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Download Buttons
          _buildStoreButton(
            left: 100,
            top: 673,
            title: 'Download on the',
            subtitle: 'App Store',
          ),
          _buildStoreButton(
            left: 250,
            top: 673,
            title: 'Get it on',
            subtitle: 'Google Play',
          ),
          _buildStoreButton(
            left: 400,
            top: 673,
            title: 'Download for',
            subtitle: 'macOS',
          ),
          _buildStoreButton(
            left: 550,
            top: 673,
            title: 'Download for',
            subtitle: 'Windows',
          ),
        ],
      ),
    );
  }

  static Widget _buildStoreButton({
    required double left,
    required double top,
    required String title,
    required String subtitle,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: 140,
        height: 38,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 6,
              top: 7,
              child: Container(width: 24, height: 24), // Placeholder for icon
            ),
            Positioned(
              left: 34,
              top: 6,
              child: SizedBox(
                width: 90,
                child: Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF1B191C),
                    fontSize: 8,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 34,
              top: 14,
              child: SizedBox(
                width: 90,
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: const Color(0xFF1B191C),
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ================= PACKAGE SECTION ==================

class PackageSection extends StatelessWidget {
  const PackageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      PackagePlan(
        title: 'Starter',
        price: 'Free',
        subtitle: '',
        description: 'Free forever when you host with Debbi. Free for freelancers with Client Billing.',
        features: [
          '2 Projects',
          'Client Billing',
          'Free Staging',
          'Code Export',
          'White labeling',
          'Site password protection',
        ],
        isRecommended: false,
        buttonLabel: 'Current plan',
      ),
      PackagePlan(
        title: 'Lite',
        price: '\$16',
        subtitle: '(Recommended)',
        description: 'Free forever when you host with Debbi. Free for freelancers with Client Billing.',
        features: [
          '2 Projects',
          'Client Billing',
          'Free Staging',
          'Code Export',
          'White labeling',
          'Site password protection',
        ],
        isRecommended: true,
        buttonLabel: 'Current plan',
      ),
      PackagePlan(
        title: 'Pro',
        price: '\$35',
        subtitle: '',
        description: 'Free forever when you host with Debbi. Free for freelancers with Client Billing.',
        features: [
          '2 Projects',
          'Client Billing',
          'Free Staging',
          'Code Export',
          'White labeling',
          'Site password protection',
        ],
        isRecommended: false,
        buttonLabel: 'Current plan',
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      color: const Color(0xFF251F48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Choose your package',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 54,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Start off for free to try the service. Upgrade to process more files and get results faster. Available only for individual use.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 40),
          // Plan type selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _PlanTypeSelector(
                label: 'Individual',
                selected: true,
              ),
              const SizedBox(width: 48),
              _PlanTypeSelector(
                label: 'Businesses',
                selected: false,
              ),
            ],
          ),
          const SizedBox(height: 40),
          // The plans
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: plans
                .map((plan) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _PlanCard(plan: plan),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class PackagePlan {
  final String title;
  final String price;
  final String subtitle;
  final String description;
  final List<String> features;
  final bool isRecommended;
  final String buttonLabel;

  PackagePlan({
    required this.title,
    required this.price,
    required this.subtitle,
    required this.description,
    required this.features,
    required this.isRecommended,
    required this.buttonLabel,
  });
}

class _PlanTypeSelector extends StatelessWidget {
  final String label;
  final bool selected;

  const _PlanTypeSelector({
    required this.label,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 36,
          height: 36,
          decoration: ShapeDecoration(
            color: Colors.black,
            shape: OvalBorder(
              side: BorderSide(
                width: 7,
                color: selected ? const Color(0xFF5548A4) : Colors.transparent,
              ),
            ),
            shadows: selected
                ? [
                    const BoxShadow(
                      color: Color(0xFF6A5ACD),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
        ),
        const SizedBox(width: 16),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontFamily: 'Tomorrow',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  final PackagePlan plan;

  const _PlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    final borderColor = plan.isRecommended ? const Color(0xFF2E2E3A) : const Color(0xFF2E2E3A);
    final cardColor = plan.isRecommended ? const Color(0xFF2E2E3A) : const Color(0xFF242430);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(
          color: borderColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: plan.isRecommended
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 57,
                  offset: const Offset(0, 14),
                  spreadRadius: 5,
                )
              ]
            : [],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              plan.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            if (plan.subtitle.isNotEmpty)
              Text(
                plan.subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            const SizedBox(height: 6),
            Text(
              plan.price,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF6A5ACD),
                fontSize: 50,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            if (plan.price != 'Free')
              const Text(
                '/Year',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF6A5ACD),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            const SizedBox(height: 8),
            Text(
              plan.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 18),
            for (final feature in plan.features)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    const Icon(Icons.check, color: Color(0xFFA008B8), size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF50449A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {},
                child: Text(
                  plan.buttonLabel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// =============== FAQ SECTION ====================

class _FaqSection extends StatelessWidget {
  const _FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1441,
      height: 822,
      color: const Color(0xFFF0EFFA),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 95,
            child: Container(
              width: 1440,
              height: 632,
              child: Stack(
                children: [
                  // Section Title
                  Positioned(
                    left: 381,
                    top: 0,
                    child: Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                        color: const Color(0xFF18191F),
                        fontSize: 48,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        height: 1.33,
                      ),
                    ),
                  ),
                  // FAQs List
                  Positioned(
                    left: 120,
                    top: 144,
                    child: SizedBox(
                      width: 600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FaqTile(
                            color: const Color(0xFF6A5ACD),
                            text: "What is a Payment Gateway?",
                          ),
                          _FaqTile(
                            color: const Color(0xFFA5A6F6),
                            text: "Do I need to pay to Instapay even when there is no transaction going on in my business?",
                          ),
                          _FaqTile(
                            color: const Color(0xFFA5A6F6),
                            text: "What platforms does Instapay payment gateway support?",
                          ),
                          _FaqTile(
                            color: const Color(0xFFA5A6F6),
                            text: "Does Instapay provide international payments support?",
                          ),
                          _FaqTile(
                            color: const Color(0xFFA5A6F6),
                            text: "Is there any setup fee or annual maintainance fee that I need to pay regularly?",
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Main Info Card
                  Positioned(
                    left: 672,
                    top: 112,
                    child: Container(
                      width: 648,
                      height: 472,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9E6F8),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x26000000),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 144, top: 40, right: 32, bottom: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'What is a Payment Gateway?',
                              style: TextStyle(
                                color: const Color(0xFF18191F),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 1.56,
                              ),
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: 472,
                              child: Text(
                                'A payment gateway is an ecommerce service that processes online payments for online as well as offline businesses. Payment gateways help accept payments by transferring key information from their merchant websites to issuing banks, card associations and online wallet players.\n\nPayment gateways play a vital role in the online transaction process, which is the realisation of value, and hence are seen as an important pillar of ecommerce.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// FAQ Tile Widget
class _FaqTile extends StatelessWidget {
  final Color color;
  final String text;

  const _FaqTile({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: color == const Color(0xFF6A5ACD)
            ? const Color(0xFFFAFBFF)
            : Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x26000000),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: ShapeDecoration(
              color: color,
              shape: const OvalBorder(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),
          const SizedBox(width: 24),
          // Placeholder for icon or actions if needed
          Container(
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}


