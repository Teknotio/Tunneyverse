import 'package:flutter/material.dart';
import 'package:tuneyverse/pages/widgets/features/song_instrumental/clean.dart';
import 'package:tuneyverse/pages/widgets/features/song_instrumental/dirty.dart';

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
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
                    // Comparison Row Centered
          Positioned(
            top: 210,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 1351,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    OriginalRecording(), // <-- use your widget
                    CleanedRecording(),  // <-- use your widget
                  ],
                ),
              ),
            ),
          ),
          // Subtitle Centered
          const Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 1254,
                child: Text(
                  ' AI-powered vocal remover is useful for a wide range of users',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 54,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          // User Groups Section Centered
          Positioned(
            top: 570,
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
            const Text(
              'Sound Quality',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 40,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.20,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              ' AI-powered vocal remover is useful for a wide range of users',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 32,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 1.20,
              ),
            ),
            const SizedBox(height: 24),
            const OriginalRecording(),
            const SizedBox(height: 16),
            const CleanedRecording(),
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
            'Extract vocals or instrumentals with precision to create remixes, mashups, or sample packs without spending hours manually separating tracks. Save time and focus on creativity by starting with clean stems.',
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
      );
    } else {
      // MOBILE VIEW
      return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
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
                                height: 1.36,
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
