import 'package:flutter/material.dart';

// ------------------- Karaoke Video DESKTOP DASHBOARD CONTENT -------------------
class KaraokeVideoDesktopSection extends StatelessWidget {
  final String title;
  final int sectionIndex;
  final VoidCallback onUpload;
  const KaraokeVideoDesktopSection({
    Key? key,
    required this.title,
    required this.sectionIndex,
    required this.onUpload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List your background images from assets
    final List<String> backgroundImages = [
      'assets/images/bg1.png',
      'assets/images/bg2.png',
      'assets/images/bg3.png',
      'assets/images/bg4.png',
    ];

    // IMPORTANT: This fixes Stack layout bug!
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 600, // Or your preferred min height
        maxHeight: 900, // Or your preferred max height
      ),
      child: Stack(
        children: [
          // Optional debug background, remove if not needed
          Container(color: Color(0xFFF8F7FC)),
          // Main title and subtitle
          Positioned(
            left: 63,
            top: 37,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and subtitle
                const Text(
                  'Karaoke Video',
                  style: TextStyle(
                    color: Color(0xFF30285C),
                    fontSize: 32,
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    height: 0.93,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Create a Karaoke Video',
                  style: TextStyle(
                    color: Color(0xFF30285C),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.32,
                  ),
                ),
                const SizedBox(height: 80),
                // Option cards row 1
                SizedBox(
                  width: 670,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _KaraokeOptionCard(
                            iconAsset: 'assets/icons/chorus_lyric.png',
                            text: 'Chorus and Lyric Video',
                            textColor: const Color(0xFFFFECEC),
                          ),
                          const SizedBox(width: 44),
                          _KaraokeOptionCard(
                            iconAsset: 'assets/icons/vid_lyric.png',
                            text: 'Instrumental and Lyric Video',
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          _KaraokeOptionCard(
                            iconAsset: 'assets/icons/song_lyric.png',
                            text: 'Song and Lyric Video',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // "Choose a Background Image" title
          const Positioned(
            left: 63,
            top: 431,
            child: SizedBox(
              width: 292,
              child: Text(
                'Choose a Background Image',
                style: TextStyle(
                  color: Color(0xFF30285C),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.40,
                ),
              ),
            ),
          ),
          // Background image previews (from assets)
          Positioned(
            left: 234,
            top: 490,
            child: Row(
              children: List.generate(backgroundImages.length, (i) {
                return Padding(
                  padding: EdgeInsets.only(right: i < backgroundImages.length - 1 ? 20.0 : 0),
                  child: Container(
                    width: 100,
                    height: 77,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(backgroundImages[i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          // Upload background image text
          const Positioned(
            left: 373,
            top: 595,
            child: Text(
              'Upload background image',
              style: TextStyle(
                color: Color(0xFFEB221E),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KaraokeOptionCard extends StatelessWidget {
  final String iconAsset;
  final String text;
  final Color? textColor;

  const _KaraokeOptionCard({
    required this.iconAsset,
    required this.text,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 74,
      decoration: BoxDecoration(
        color: const Color(0xFF251F48),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Image.asset(iconAsset, width: 24, height: 24, color: Colors.white),
          const SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 13,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 1.72,
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------- Karaoke Video MOBILE Section CONTENT -------------------

class KaraokeVideoMobileSection extends StatelessWidget {
  final String title;
  final int sectionIndex;
  final VoidCallback onUpload;

  const KaraokeVideoMobileSection({
    Key? key,
    required this.title,
    required this.sectionIndex,
    required this.onUpload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> backgroundImages = [
      'assets/images/bg1.png',
      'assets/images/bg2.png',
      'assets/images/bg3.png',
      'assets/images/bg4.png',
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Karaoke Video',
              style: TextStyle(
                color: Color(0xFF30285C),
                fontSize: 32,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                height: 0.93,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a Karaoke Video',
              style: TextStyle(
                color: Color(0xFF30285C),
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.32,
              ),
            ),
            const SizedBox(height: 38),
            _KaraokeOptionCardMobile(
              iconAsset: 'assets/icons/chorus_lyric.png',
              text: 'Chorus and Lyric Video',
              textColor: const Color(0xFFFFECEC),
            ),
            const SizedBox(height: 16),
            _KaraokeOptionCardMobile(
              iconAsset: 'assets/icons/vid_lyric.png',
              text: 'Instrumental and Lyric Video',
            ),
            const SizedBox(height: 16),
            _KaraokeOptionCardMobile(
              iconAsset: 'assets/icons/song_lyric.png',
              text: 'Song and Lyric Video',
            ),
            const SizedBox(height: 40),
            const Text(
              'Choose a Background Image',
              style: TextStyle(
                color: Color(0xFF30285C),
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.40,
              ),
            ),
            const SizedBox(height: 20),

            // UPDATED: Use Column for images
            Column(
              children: List.generate(backgroundImages.length, (i) {
                return Padding(
                  padding: EdgeInsets.only(bottom: i < backgroundImages.length - 1 ? 18.0 : 0),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(backgroundImages[i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),
            Center(
              child: Text(
                'Upload background image',
                style: TextStyle(
                  color: Color(0xFFEB221E),
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _KaraokeOptionCardMobile extends StatelessWidget {
  final String iconAsset;
  final String text;
  final Color? textColor;

  const _KaraokeOptionCardMobile({
    required this.iconAsset,
    required this.text,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // Responsive sizing:
    final double cardHeight = (screenWidth * 0.18).clamp(54.0, 90.0);
    final double iconSize = (screenWidth * 0.08).clamp(20.0, 32.0);
    final double fontSize = (screenWidth * 0.042).clamp(13.0, 18.0);
    final double horizontalPadding = (screenWidth * 0.045).clamp(8.0, 22.0);
    final double gap = (screenWidth * 0.03).clamp(8.0, 16.0);

    return Container(
      width: double.infinity,
      height: cardHeight,
      margin: EdgeInsets.symmetric(vertical: cardHeight * 0.08),
      decoration: BoxDecoration(
        color: const Color(0xFF251F48),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            iconAsset,
            width: iconSize,
            height: iconSize,
            color: Colors.white,
          ),
          SizedBox(width: gap),
          // Responsive text
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: fontSize,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
