import 'package:flutter/material.dart';

class MissionVisionSection extends StatelessWidget {
  const MissionVisionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth > 800;
        final horizontalPadding = isDesktop ? 64.0 : 20.0;
        final verticalPadding = isDesktop ? 112.0 : 64.0;
        final maxBoxWidth = isDesktop ? 1280.0 : double.infinity;
        final imageHeight = isDesktop ? 738.0 : 188.0;
        final headingFontSize = isDesktop ? 48.0 : 36.0;
        final bodyFontSize = 24.0;
        final headingWidth = isDesktop ? 768.0 : 335.0;
        final spacing = isDesktop ? 80.0 : 48.0;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxBoxWidth),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: isDesktop ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    // Main Image
                    Container(
                      width: double.infinity,
                      height: imageHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        image: DecorationImage(
                          image: AssetImage('assets/mission_vision.png'), // <--- your asset path here!
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: spacing),
                    // Text Section
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: isDesktop ? 768.0 : 768.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: headingWidth,
                            child: Text(
                              'Our Vision and Mission',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: headingFontSize,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                height: 1.20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: headingWidth,
                            child: Text(
                              '''At Tuneyverse, we believe in the transformative power of music. Our vision is to create a platform where karaoke enthusiasts and music creators can unleash their creativity without boundaries. We strive to empower users by providing innovative tools that make music processing accessible and enjoyable for everyone.

What sets Tuneyverse apart is our commitment to quality and user experience. Unlike other platforms, we offer advanced AI technology that ensures seamless extraction of instrumentals and vocals, allowing for a more refined karaoke experience. Our user-friendly interface is designed for both novices and professionals, ensuring that everyone can create stunning music videos effortlessly.

Our mission is simple: to revolutionize the way people interact with music. We provide an array of features, from extracting choruses to creating full lyric videos, all tailored to enhance your musical journey. Whether you're a budding artist or a karaoke lover, Tuneyverse is your go-to destination for all things music.

Join us as we bridge the gap between technology and creativity. With Tuneyverse, you can easily transform your favorite songs into personalized experiences, making every performance unique. Our platform is built on the belief that music should be accessible and fun, and we are here to make that a reality.

Welcome to Tuneyverse where innovation meets passion, and every note counts. Together, let's redefine the music landscape and inspire a new generation of creators.''',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: bodyFontSize,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: isDesktop ? 1.40 : 1.50,
                              ),
                            ),
                          ),
                        ],
                      ),
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
