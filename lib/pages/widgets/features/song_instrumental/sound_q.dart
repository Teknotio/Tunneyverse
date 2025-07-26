import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/widgets/features/clean_record.dart';
import 'package:tuneyverse/pages/widgets/features/og_record.dart';

class SoundQuality extends StatelessWidget {
  const SoundQuality({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    return isDesktop ? _buildDesktopView() : _buildMobileView();
  }

  Widget _buildDesktopView() {
    return Container(
      width: 1440,
      height: 1192,
      color: const Color(0xFFF0EFFA),
      child: Stack(
        children: [
          // Main Title Centered
          const Positioned(
            top: 42,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Sound Quality',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: 54,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Comparison Row Centered
          Positioned(
            top: 161,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 1351,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    NetworkAudioPlayer(audioUrl: '',),
                    CleanedRecordingWidget(),
                  ],
                ),
              ),
            ),
          ),
          // User Groups Section Centered
          Positioned(
            top: 441,
            left: 0,
            right: 0,
            child: Center(
              child: _userGroups(isDesktop: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Main Title (already centered)
            Text(
              'Sound Quality',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF1E1E1E),
                fontSize: 40,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700,
                height: 1.20,
              ),
            ),
            const SizedBox(height: 24),
            const NetworkAudioPlayer(audioUrl: 'https://drive.google.com/uc?export=download&id=1QyAJP1-5P_Qtn6A8lm69bvgEiAQZb9PQ',),
            const SizedBox(height: 16),
            const CleanedRecordingWidget(),
            const SizedBox(height: 32),
            _userGroups(isDesktop: false),
          ],
        ),
      ),
    );
  }

  static Widget _userGroups({required bool isDesktop}) {
    final groups = [
      {
        'iconAsset': 'assets/icons/dj.png',
        'title': 'Music Producers & DJs',
        'desc':
            'Extract vocals with precision to create remixes, mashups, or sample packs without spending hours manually separating tracks. Save time and focus on creativity by starting with clean stems.',
      },
      {
        'iconAsset': 'assets/icons/rec.png',
        'title': 'Karaoke Enthusiasts',
        'desc':
            'Generate karaoke tracks at home by removing lead vocals while preserving the chorus and backing instrumentals. Sing along to your favorite songs with high-quality audio separation.',
      },
      {
        'iconAsset': 'assets/icons/mic.png',
        'title': 'Podcasters & Voiceover Artists',
        'desc':
            'Clean up background music or noise from audio recordings to produce clearer, more professional-sounding content. Improve intelligibility and listener experience.',
      },
      {
        'iconAsset': 'assets/icons/vid.png',
        'title': 'Content Creators & Video Editors',
        'desc':
            'Remove copyrighted vocals from songs used in your videos, allowing you to keep the background music without risking takedowns or demonetization. Perfect for vlogs, tutorials, and cinematic edits.',
      },
    ];

    if (isDesktop) {
      // DESKTOP VIEW - centered with fixed width
      return SizedBox(
        width: 1298,
        height: 685,
        child: Stack(
          children: [
            // Subtitle centered at the top
            Positioned(
              left: 22,
              top: 0,
              child: SizedBox(
                width: 1254,
                child: Text(
                  ' AI-powered vocal remover is useful for a wide range of users',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF1E1E1E),
                    fontSize: 54,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // The user group boxes in a grid
            Positioned(
              left: 0,
              top: 213,
              child: SizedBox(
                width: 1298,
                child: Wrap(
                  spacing: 24,
                  runSpacing: 40,
                  children: groups.map((g) {
                    return SizedBox(
                      width: 622,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Avatar with image asset
                          Container(
                            width: 120,
                            height: 120,
                            margin: const EdgeInsets.only(right: 24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                            ),
                            child: Center(
                              child: Image.asset(
                                g['iconAsset'] as String,
                                width: 56,
                                height: 56,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          // Text content
                          SizedBox(
                            width: 478,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  g['title']!,
                                  style: const TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 28,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  g['desc']!,
                                  style: const TextStyle(
                                    color: Color(0xFF1B191C),
                                    fontSize: 22,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 1.36,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // MOBILE VIEW
      return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: 335,
                child: Text(
                  ' AI-powered vocal remover is useful for a wide range of users',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 40,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 1.20,
                  ),
                ),
              ),
            ),
            ...groups.map((g) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: SizedBox(
                  width: 335,
                  child: Column(
                    children: [
                      // Avatar with image asset
                      Container(
                        width: 120,
                        height: 120,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Center(
                          child: Image.asset(
                            g['iconAsset'] as String,
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 294,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              g['title']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF1E1E1E),
                                fontSize: 28,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              g['desc']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF1B191C),
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      );
    }
  }
}
