import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:audio_waveforms/audio_waveforms.dart' as aw;
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class NetworkAudioPlayer extends StatefulWidget {
  final String audioUrl;
  const NetworkAudioPlayer({super.key, required this.audioUrl});

  @override
  State<NetworkAudioPlayer> createState() => _NetworkAudioPlayerState();
}

class _NetworkAudioPlayerState extends State<NetworkAudioPlayer> {
  late ja.AudioPlayer _player;
  late aw.PlayerController _waveformController;
  bool _loading = true;
  bool _isPlaying = false;
  bool _waveformReady = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  String? _localPath;

  @override
  void initState() {
    super.initState();
    _player = ja.AudioPlayer();
    _waveformController = aw.PlayerController();
    _listenStreams();
    _initAudio();
  }

  void _listenStreams() {
    _player.durationStream.listen((d) {
      if (d != null) setState(() => _duration = d);
    });
    _player.positionStream.listen((pos) {
      setState(() => _position = pos);
    });
    _player.playerStateStream.listen((state) {
      setState(() => _isPlaying = state.playing);
    });
  }

  Future<void> _initAudio() async {
    setState(() { _loading = true; });

    try {
      // 1. Download file to local temp
      final localPath = await _downloadFile(widget.audioUrl);
      _localPath = localPath;

      // 2. Play from the network (streaming) for just_audio
      await _player.setUrl(widget.audioUrl);

      // 3. Prepare waveform from the local file
      await _waveformController.preparePlayer(
        path: localPath,
        shouldExtractWaveform: true,
        noOfSamples: 100,
      );

      setState(() {
        _loading = false;
        _waveformReady = true;
      });
    } catch (e) {
      setState(() { _loading = false; });
      print("Error: $e");
    }
  }

  Future<String> _downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final tempDir = await getTemporaryDirectory();
    final filename = 'audio_from_url_${DateTime.now().microsecondsSinceEpoch}.mp3';
    final file = File('${tempDir.path}/$filename');
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  String _formatTime(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _player.pause();
      await _waveformController.pausePlayer();
    } else {
      await _player.play();
      await _waveformController.startPlayer();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _waveformController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final waveWidth = screenWidth > 700 ? 600.0 : screenWidth - 48.0;

    return Center(
      child: Container(
        width: isMobile ? double.infinity : 661.0,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16.0 : 32.0,
          vertical: isMobile ? 16.0 : 32.0,
        ),
        decoration: ShapeDecoration(
          color: const Color(0xFF323033),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                    color: Colors.white,
                    size: isMobile ? 40.0 : 48.0,
                  ),
                  onPressed: _loading ? null : _togglePlayPause,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    widget.audioUrl,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 14.0 : 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12.0),
                Text(
                  '${_formatTime(_position)} / ${_formatTime(_duration)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 12.0 : 14.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            if (_loading)
              Container(
                alignment: Alignment.center,
                height: 80.0,
                child: const CircularProgressIndicator(color: Colors.white),
              )
            else if (_waveformReady)
              aw.AudioFileWaveforms(
                size: Size(waveWidth, 64.0),
                playerController: _waveformController,
                waveformType: aw.WaveformType.long,
                continuousWaveform: true,
                enableSeekGesture: true,
                playerWaveStyle: aw.PlayerWaveStyle(
                  fixedWaveColor: const Color(0xFFF0EFFA),
                  liveWaveColor: Colors.blueAccent,
                  spacing: 6.0,
                  waveThickness: 3.5,
                  showSeekLine: true,
                  seekLineThickness: 3.0,
                  showTop: true,
                ),
              )
            else
              Container(
                alignment: Alignment.center,
                height: 80.0,
                child: Text(
                  'Loading audio...',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isMobile ? 14.0 : 16.0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
