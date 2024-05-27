import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/constants/assets.dart';
import 'package:video_player/video_player.dart';

class TbtVideo extends StatefulWidget {
  final DataSourceType dataSourceType;
  final String url;
  const TbtVideo({
    super.key,
    required this.dataSourceType,
    required this.url,
  });

  @override
  State<TbtVideo> createState() => _TbtVideoState();
}

class _TbtVideoState extends State<TbtVideo> {
  late ChewieController _chewieController;
  late VideoPlayerController _videoPlayerController;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
      widget.url,
    )..initialize().then((_) {
        setState(() {});
      });

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      placeholder: Image.asset(
        Assets.thumbNail,
      ),
      autoPlay: false,
      showControls: false,
    );
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
      } else {
        _videoPlayerController.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            Chewie(
              controller: _chewieController,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: VideoProgressIndicator(
                _videoPlayerController,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  playedColor: Colors.purple,
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
            AnimatedPositioned(
              curve: Curves.linear,
              duration: const Duration(milliseconds: 800),
              bottom: _videoPlayerController.value.isPlaying ? 10 : 45,
              left: _videoPlayerController.value.isPlaying ? 3 : 120,
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: Icon(
                  size: _videoPlayerController.value.isPlaying ? 25 : 100,
                  _videoPlayerController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: const Color.fromARGB(255, 155, 39, 176),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
