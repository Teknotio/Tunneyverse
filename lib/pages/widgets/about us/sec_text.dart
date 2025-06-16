import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutUsTextSection extends StatelessWidget {
  const AboutUsTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth > 800;

        final horizontalPadding = isDesktop ? 64.0 : 20.0;
        final verticalPadding = isDesktop ? 112.0 : 64.0;
        final headingWidth = isDesktop ? 768.0 : 335.0;
        final contentWidth = isDesktop ? 768.0 : 335.0;
        final maxBoxWidth = isDesktop ? 1280.0 : double.infinity;
        final sectionSpacing = isDesktop ? 64.0 : 32.0;
        final imageHeight = isDesktop ? 400.0 : 174.0;
        final imageVertical = isDesktop ? 48.0 : 40.0;
        final tagFontSize = 14.0;
        final headingFontSize = 48.0;
        final subHeadingFontSize = isDesktop ? 32.0 : 24.0;
        final bodyFontSize = isDesktop ? 24.0 : 20.0;

        final socialIcons = [
          'assets/icons/link-alt.svg',
          'assets/icons/facebook.svg',
          'assets/icons/x.svg',
          'assets/icons/linkedin.svg',
        ];

        // ---- DESKTOP (keeps structure) ----
        if (isDesktop) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Color(0xFFF0EFFA), // Background color
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxBoxWidth),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: headingWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Heading
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: SizedBox(
                                width: headingWidth,
                                child: Text(
                                  'Empowering Your Music Journey',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: headingFontSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            // Paragraphs
                            ...[
                              'At Tuneyverse, we harness the power of AI to revolutionize the way you experience music. Our core services include advanced music extraction, allowing you to effortlessly separate vocals, instrumentals, and choruses from your favorite tracks. Whether you\'re a karaoke enthusiast or a music creator, our platform provides the tools you need to elevate your musical projects.',
                              'Creating karaoke tracks and lyric videos has never been easier. With just a few clicks, you can generate stunning videos that feature either the full song, just the instrumental, or the chorus. This flexibility ensures that you can customize your content to suit your audience, making every performance or presentation unique.',
                            ].map(
                              (text) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: SizedBox(
                                  width: contentWidth,
                                  child: Text(
                                    text,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: bodyFontSize,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Main Asset Image
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: imageVertical),
                              child: Container(
                                width: double.infinity,
                                height: imageHeight,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/about_main.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            // More paragraphs
                            ...[
                              'We pride ourselves on offering intuitive tools designed for both beginners and seasoned musicians. Our user-friendly interface simplifies the music processing experience, enabling you to focus on what truly matters: your creativity. No more complicated software or lengthy tutorials; Tuneyverse makes it accessible for everyone',
                              'Our commitment to innovation means that we continuously improve our technology, ensuring that you have the best tools at your fingertips. Fast, reliable, and efficient, our services are designed to meet the demands of today’s music landscape, empowering you to create and share your passion with the world.',
                            ].map(
                              (text) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: SizedBox(
                                  width: contentWidth,
                                  child: Text(
                                    text,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: bodyFontSize,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24, bottom: 20),
                              child: SizedBox(
                                width: contentWidth,
                                child: Text(
                                  'Conclusion',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: subHeadingFontSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: SizedBox(
                                width: contentWidth,
                                child: Text(
                                  'Join us at Tuneyverse and discover how our AI-powered solutions can transform your music journey. Whether you\'re looking to create unforgettable karaoke experiences or produce high-quality lyric videos, we are here to support your musical aspirations.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: bodyFontSize,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: sectionSpacing),
                      // Share and Tags/Team
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Share Section
                          Column(
                            children: [
                              Text(
                                'Share This Post',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: isDesktop ? 18 : 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: socialIcons.map((iconPath) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(64),
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: SvgPicture.asset(
                                        iconPath,
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                )).toList(),
                              ),
                            ],
                          ),
                          SizedBox(height: sectionSpacing),
                          // Tags
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              'Music Innovation',
                              'Karaoke Lovers',
                              'Creative Tools',
                              'Music Processing',
                            ]
                                .map(
                                  (tag) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEEEEEE),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      tag,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: tagFontSize,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(height: sectionSpacing),
                          // Team Section
                          Column(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage('assets/team.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Team Tuneyverse',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: tagFontSize,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                              Text(
                                'Music Enthusiast, Tuneyverse',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: tagFontSize,
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
                  ),
                ),
              ],
            ),
          );
        }

        // ---- MOBILE (REPLACES ALL TEXT AS REQUESTED) ----
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Color(0xFFF0EFFA), // Background color
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxBoxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: SizedBox(
                        width: headingWidth,
                        child: Text(
                          'Empowering Your Music Journey',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 48,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                    // Text blocks
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: contentWidth,
                        child: Text(
                          'At Tuneyverse, we harness the power of AI to revolutionize the way you experience music. Our core services include advanced music extraction, allowing you to effortlessly separate vocals, instrumentals, and choruses from your favorite tracks. Whether you\'re a karaoke enthusiast or a music creator, our platform provides the tools you need to elevate your musical projects.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: contentWidth,
                        child: Text(
                          'Creating karaoke tracks and lyric videos has never been easier. With just a few clicks, you can generate stunning videos that feature either the full song, just the instrumental, or the chorus. This flexibility ensures that you can customize your content to suit your audience, making every performance or presentation unique.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: contentWidth,
                        child: Text(
                          'We pride ourselves on offering intuitive tools designed for both beginners and seasoned musicians. Our user-friendly interface simplifies the music processing experience, enabling you to focus on what truly matters: your creativity. No more complicated software or lengthy tutorials; Tuneyverse makes it accessible for everyone',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: contentWidth,
                        child: Text(
                          'Our commitment to innovation means that we continuously improve our technology, ensuring that you have the best tools at your fingertips. Fast, reliable, and efficient, our services are designed to meet the demands of today’s music landscape, empowering you to create and share your passion with the world.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 20),
                      child: SizedBox(
                        width: contentWidth,
                        child: Text(
                          'Conclusion',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: SizedBox(
                        width: contentWidth,
                        child: Text(
                          'Join us at Tuneyverse and discover how our AI-powered solutions can transform your music journey. Whether you\'re looking to create unforgettable karaoke experiences or produce high-quality lyric videos, we are here to support your musical aspirations.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    // Share section
                    Text(
                      'Share This Post',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: socialIcons.map((iconPath) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(64),
                            ),
                          ),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: SvgPicture.asset(
                              iconPath,
                              width: 24,
                              height: 24,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )).toList(),
                    ),
                    SizedBox(height: sectionSpacing),
                    // Tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        'Music Innovation',
                        'Karaoke Lovers',
                        'Creative Tools',
                        'Music Processing',
                      ]
                          .map(
                            (tag) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: tagFontSize,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: sectionSpacing),
                    // Team Section
                    Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/team.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Team Tuneyverse',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: tagFontSize,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                        Text(
                          'Music Enthusiast, Tuneyverse',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: tagFontSize,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
