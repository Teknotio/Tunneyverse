import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoQuality extends StatefulWidget {
  const VideoQuality({super.key});

  @override
  State<VideoQuality> createState() => _VideoQualityState();
}

class _VideoQualityState extends State<VideoQuality> {
  VideoPlayerController? _controller;
  bool _showOverlay = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video_preview.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    _controller?.addListener(() {
      if (_controller!.value.isPlaying != !_showOverlay) {
        setState(() {
          _showOverlay = !_controller!.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onPlayPause() {
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller?.pause();
      } else {
        _controller?.play();
      }
      _showOverlay = !_controller!.value.isPlaying;
    });
  }

  static const List<Map<String, String>> _groups = [
    {
      'icon': 'assets/icons/dj.png',
      'title': 'Music Producers & DJs',
      'desc': 'Use full-song lyric videos to analyze vocal timing, structure, and phrasing, great for sampling, remixes, or reference in studio sessions.',
    },
    {
      'icon': 'assets/icons/rec.png',
      'title': 'Karaoke Enthusiasts',
      'desc': 'Generate high-quality lyric videos with song so you can sing along just like in a real karaoke session, no setup or editing required.',
    },
    {
      'icon': 'assets/icons/mic.png',
      'title': 'Music Teachers & Students',
      'desc': 'Help students follow along with synchronized lyrics while listening to the original track, ideal for vocal training, language learning, and music comprehension.',
    },
    {
      'icon': 'assets/icons/vid.png',
      'title': 'Content Creators & Video Editors',
      'desc': 'Generate lyric videos from full tracks to enhance music reactions, covers, or storytelling content, without altering the original song or risking sync issues.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;
    return isDesktop ? _buildDesktop(context) : _buildMobile(context);
  }

  Widget _buildVideoBox({double width = 875, double height = 508}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: _controller != null && _controller!.value.isInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                ),
                if (_showOverlay)
                  GestureDetector(
                    onTap: _onPlayPause,
                    child: Container(
                      color: Colors.black26,
                      child: Icon(
                        Icons.play_circle_fill,
                        size: width / 4,
                        color: Colors.white.withOpacity(0.85),
                      ),
                    ),
                  )
                else
                  GestureDetector(
                    onTap: _onPlayPause,
                    child: Container(color: Colors.transparent),
                  ),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Center(
      child: Container(
        width: 1440,
        height: 1344,
        color: const Color(0xFFF0EFFA),
        child: Stack(
          children: [
            Positioned(
              left: 0, right: 0, top: 31,
              child: Center(
                child: Text(
                  'Sound and Video Quality',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF1E1E1E),
                    fontSize: 54,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0, right: 0, top: 127,
              child: Center(child: _buildVideoBox()),
            ),
            Positioned(
              left: 0, right: 0, top: 643,
              child: Center(
                child: SizedBox(
                  width: 1254,
                  child: Text(
                    ' AI-powered vocal remover is useful for a wide range of users',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 54,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0, right: 0, top: 829,
              child: Center(
                child: SizedBox(
                  width: 1298,
                  child: Wrap(
                    spacing: 40,
                    runSpacing: 40,
                    alignment: WrapAlignment.center,
                    children: _groups.map((g) {
                      return SizedBox(
                        width: 600,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              margin: const EdgeInsets.only(right: 24),
                              child: Image.asset(
                                g['icon']!,
                                width: 56,
                                height: 56,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Flexible(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobile(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: 375,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 64),
          color: const Color(0xFFF0EFFA),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 335,
                child: Text(
                  'Sound and Video Quality',
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
              const SizedBox(height: 32),
              _buildVideoBox(width: 335, height: 194),
              const SizedBox(height: 32),
              SizedBox(
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
              const SizedBox(height: 40),
              ..._groups.map((g) => Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: SizedBox(
                  width: 335,
                  child: Column(
                    children: [
                      Container(
                        width: 120, height: 120, margin: const EdgeInsets.only(bottom: 16),
                        child: Image.asset(
                          g['icon']!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.contain,
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
              )),
            ],
          ),
        ),
      ),
    );
  }
}
