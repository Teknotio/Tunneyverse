import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_waveforms/audio_waveforms.dart';

class OriginalRecording extends StatefulWidget {
  const OriginalRecording({Key? key}) : super(key: key);

  @override
  State<OriginalRecording> createState() => _OriginalRecordingState();
}

class _OriginalRecordingState extends State<OriginalRecording> {
  late AudioPlayer _player;
  late PlayerController _waveformController;

  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _waveformController = PlayerController();
    _init();
  }

  Future<void> _init() async {
    try {
      await _player.setAsset('assets/audio/original.mp3');
      // Prepare waveform controller with your audio asset
      await _waveformController.preparePlayer(
        path: 'assets/audio/original.mp3',
        shouldExtractWaveform: true,
      );
      _player.durationStream.listen((d) {
        if (d != null) setState(() => _duration = d);
      });
      _player.positionStream.listen((p) {
        setState(() => _position = p);
      });
      _player.playerStateStream.listen((state) {
        setState(() => _isPlaying = state.playing);
      });
    } catch (e) {
      print('Error loading audio: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    _waveformController.dispose();
    super.dispose();
  }

  String _formatTime(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 661,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF323033),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Header Row: Play/Pause + Title + Time
          Positioned(
            left: 20,
            top: 20,
            right: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: IconButton(
                    icon: Icon(
                      _isPlaying
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_filled,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      if (_isPlaying) {
                        _player.pause();
                        _waveformController.pausePlayer();
                      } else {
                        _player.play();
                        _waveformController.startPlayer();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                const SizedBox(
                  width: 231.58,
                  height: 32,
                  child: Text(
                    'Original recording',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.14,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${_formatTime(_position)} / ${_formatTime(_duration)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    height: 1.42,
                    letterSpacing: -0.30,
                  ),
                ),
              ],
            ),
          ),
          // The waveform:
          Positioned(
            left: 20,
            right: 20,
            top: 75,
            child: AudioFileWaveforms(
              size: const Size(600, 90),
              playerController: _waveformController,
              waveformType: WaveformType.fitWidth,
              playerWaveStyle: const PlayerWaveStyle(
                fixedWaveColor: Colors.white,
                liveWaveColor: Color(0xFFB29CFD),
                showSeekLine: false,
                waveCap: StrokeCap.round,
                waveThickness: 4.0,
                spacing: 5.0,
              ),
              enableSeekGesture: true,
            ),
          ),
        ],
      ),
    );
  }
}
