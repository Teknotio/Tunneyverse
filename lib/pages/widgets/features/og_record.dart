import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';

class OriginalRecordingWidget extends StatefulWidget {
  const OriginalRecordingWidget({super.key});

  @override
  State<OriginalRecordingWidget> createState() => _OriginalRecordingWidgetState();
}

class _OriginalRecordingWidgetState extends State<OriginalRecordingWidget> {
  late AudioPlayer _player;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  bool _isPlaying = false;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<PlayerState>? _playerStateSub;
  StreamSubscription<Duration?>? _durationSub;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    try {
      print('🔊 Loading audio asset...');
      await _player.setAsset('assets/audio/original.mp3');
      print('✅ Audio loaded!');

      _durationSub = _player.durationStream.listen((d) {
        if (d != null) {
          setState(() => _duration = d);
        }
      });

      _positionSub = _player.positionStream.listen((pos) {
        setState(() => _position = pos);
      });

      _playerStateSub = _player.playerStateStream.listen((state) {
        setState(() => _isPlaying = state.playing);
      });
    } catch (e) {
      print('❌ Error loading audio: $e');
    }
  }

  @override
  void dispose() {
    _durationSub?.cancel();
    _positionSub?.cancel();
    _playerStateSub?.cancel();
    _player.dispose();
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
      decoration: ShapeDecoration(
        color: const Color(0xFF323033),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Stack(
        children: [
          // Header Row: Play/Pause + Title + Time
          Positioned(
            left: 20,
            top: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Play/Pause Button
                SizedBox(
                  width: 40,
                  height: 40,
                  child: IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      if (_isPlaying) {
                        _player.pause();
                      } else {
                        _player.play();
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

          // Waveform Bars (static visuals)
          Positioned(
            left: 20,
            top: 59,
            child: Container(
              width: 625,
              height: 102,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  _buildBar(left: 5, top: 65, width: 24),
                  _buildBar(left: 10, top: 76.07, width: 50.14),
                  _buildBar(left: 15, top: 69.56, width: 37.12),
                  _buildBar(left: 20, top: 66.15, width: 30.30),
                  _buildBar(left: 25, top: 75.71, width: 49.42),
                  _buildBar(left: 30, top: 72.97, width: 43.95),
                  _buildBar(left: 35, top: 75.36, width: 48.71),
                  _buildBar(left: 40, top: 76.41, width: 50.81),
                  _buildBar(left: 45, top: 63.88, width: 25.76),
                  _buildBar(left: 50, top: 69.20, width: 36.39),
                  _buildBar(left: 55, top: 64.11, width: 26.22),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildBar({
    required double left,
    required double top,
    required double width,
  }) {
    return Positioned(
      left: left,
      top: top,
      child: Transform.rotate(
        angle: -1.57,
        child: Container(
          width: width,
          height: 0,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                color: const Color(0xFFF0EFFA),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
