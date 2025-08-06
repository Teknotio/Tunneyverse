import 'package:flutter/material.dart';

class KaraokeVideoSection extends StatelessWidget {
  final String title;
  final int sectionIndex;
  final VoidCallback onUpload;

  const KaraokeVideoSection({
    Key? key,
    required this.title,
    required this.sectionIndex,
    required this.onUpload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          // Desktop view
          return _buildDesktop(context);
        } else {
          // Mobile view
          return _buildMobile(context);
        }
      },
    );
  }

  // ------------------- DESKTOP UI -------------------
  Widget _buildDesktop(BuildContext context) {
    final List<String> backgroundImages = [
      'assets/images/bg1.png',
      'assets/images/bg2.png',
      'assets/images/bg3.png',
      'assets/images/bg4.png',
    ];

    return SizedBox.expand(
      child: Stack(
        children: [
          Container(color: Color(0xFFF8F7FC)),
          // Title, subtitle, and cards
          Positioned(
            left: 63,
            top: 37,
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
                const SizedBox(height: 80),
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
                            iconAsset: 'assets/icons/instrumental_lyric.png',
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
          // "Choose a Background Image"
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
          // Background image previews
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

  // ------------------- MOBILE UI -------------------
  Widget _buildMobile(BuildContext context) {
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
              iconAsset: 'assets/icons/instrumental_lyric.png',
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
            SizedBox(
              height: 440,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: backgroundImages.length,
                separatorBuilder: (_, __) => const SizedBox(height: 18),
                itemBuilder: (context, i) {
                  return Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(backgroundImages[i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
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

// Desktop card
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

// Mobile card
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
    return Container(
      width: double.infinity,
      height: 74,
      decoration: BoxDecoration(
        color: const Color(0xFF251F48),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Image.asset(iconAsset, width: 24, height: 24, color: Colors.white),
          const SizedBox(width: 14),
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
