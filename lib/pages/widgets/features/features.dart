import 'package:flutter/material.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    return isDesktop ? _buildDesktopView() : _buildMobileView();
  }

  Widget _buildDesktopView() {
    // These would be your real icons, swap in Image.asset if you want images!
    final List<Widget> featureIcons = [
      Icon(Icons.flash_on, size: 32, color: Color(0xFFF0EFFA)),
      Icon(Icons.upload_file, size: 32, color: Color(0xFFF0EFFA)),
      Icon(Icons.devices, size: 32, color: Color(0xFFF0EFFA)),
      Icon(Icons.auto_awesome, size: 32, color: Color(0xFFF0EFFA)),
    ];

    return Container(
      width: 1440,
      padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 112),
      decoration: const BoxDecoration(color: Color(0xFF251F48)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left info column
                SizedBox(
                  width: 380,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // "Features" subtitle
                      Text(
                        'Features',
                        style: TextStyle(
                          color: Color(0xFFF0EFFA),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          height: 1.50,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Headline
                      Text(
                        'Explore Our Exciting Additional Features',
                        style: TextStyle(
                          color: Color(0xFFF0EFFA),
                          fontSize: 48,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Body
                      Text(
                        "Discover the powerful tools that enhance your karaoke experience. From instant demos to user-friendly testing areas, we've got you covered.",
                        style: TextStyle(
                          color: Color(0xFFF0EFFA),
                          fontSize: 18,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 80),
                // Right features grid
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _FeatureColumn(
                              icon: featureIcons[0],
                              title: 'Instant Demo for Immediate Experience',
                              desc: 'Experience our AI technology in real-time.',
                            ),
                          ),
                          const SizedBox(width: 48),
                          Expanded(
                            child: _FeatureColumn(
                              icon: featureIcons[1],
                              title: 'User Testing Area for Personalized Feedback',
                              desc: 'Upload your files and see results instantly.',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 64),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _FeatureColumn(
                              icon: featureIcons[2],
                              title: 'Cross-Platform Support for All Devices',
                              desc: 'Access Tuneyverse seamlessly on any device.',
                            ),
                          ),
                          const SizedBox(width: 48),
                          Expanded(
                            child: _FeatureColumn(
                              icon: featureIcons[3],
                              title: 'Engaging User Experience Across Platforms',
                              desc: 'Enjoy a smooth interface whether on mobile or desktop.',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileView() {
    // Same order as desktop, but stacked vertically and using mobile styles
    final List<Widget> featureIcons = [
      Icon(Icons.flash_on, size: 28, color: Color(0xFFF0EFFA)),
      Icon(Icons.upload_file, size: 28, color: Color(0xFFF0EFFA)),
      Icon(Icons.devices, size: 28, color: Color(0xFFF0EFFA)),
      Icon(Icons.auto_awesome, size: 28, color: Color(0xFFF0EFFA)),
    ];
    final List<String> titles = [
      'Instant Demo for Immediate Experience',
      'User Testing Area for Personalized Feedback',
      'Cross-Platform Support for All Devices',
      'Engaging User Experience Across Platforms',
    ];
    final List<String> descs = [
      'Experience our AI technology in real-time.',
      'Upload your files and see results instantly.',
      'Access Tuneyverse seamlessly on any device.',
      'Enjoy a smooth interface whether on mobile or desktop.',
    ];

    return Container(
      width: 375,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
      decoration: const BoxDecoration(color: Color(0xFF251F48)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Features',
            style: TextStyle(
              color: Color(0xFFF0EFFA),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
              height: 1.50,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Explore Our Exciting Additional Features',
            style: TextStyle(
              color: Color(0xFFF0EFFA),
              fontSize: 36,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 1.20,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Discover the powerful tools that enhance your karaoke experience. From instant demos to user-friendly testing areas, we've got you covered.",
            style: TextStyle(
              color: Color(0xFFF0EFFA),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
          const SizedBox(height: 48),
          // Feature list
          ...List.generate(4, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: _FeatureColumn(
                icon: featureIcons[i],
                title: titles[i],
                desc: descs[i],
                isMobile: true,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _FeatureColumn extends StatelessWidget {
  final Widget icon;
  final String title;
  final String desc;
  final bool isMobile;

  const _FeatureColumn({
    required this.icon,
    required this.title,
    required this.desc,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 48, height: 48, child: Center(child: icon)),
        const SizedBox(height: 24),
        SizedBox(
          width: isMobile ? 335 : 386,
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xFFF0EFFA),
              fontSize: isMobile ? 24 : 32,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
              height: 1.30,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: isMobile ? 335 : 386,
          child: Text(
            desc,
            style: TextStyle(
              color: Color(0xFFF0EFFA),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),
        ),
      ],
    );
  }
}
