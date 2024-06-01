import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tobeto/constants/assets.dart';
import 'package:video_player/video_player.dart';

class CourseVideo extends StatefulWidget {
  const CourseVideo(
      {super.key,
      required this.dataSourceType,
      required this.videoUrl,
      required this.onFullScreenToggle});

  final DataSourceType dataSourceType;
  final String videoUrl;
  final Function(bool isFullScreen) onFullScreenToggle;

  @override
  State<CourseVideo> createState() => _CourseVideoState();
}

class _CourseVideoState extends State<CourseVideo> {
  late ChewieController _chewieController;
  late VideoPlayerController _videoPlayerController;
  late VoidCallback _listener;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.videoUrl)
          ..initialize().then((_) {
            setState(() {});
          });
        // ..addListener(_updateMaxWatchedDuration);
        break;
      case DataSourceType.network:
        videoUpdateNetwork();

        // ..addListener(_updateMaxWatchedDuration);
        break;
      case DataSourceType.file:
        _videoPlayerController =
            VideoPlayerController.file(File(widget.videoUrl));
      case DataSourceType.contentUri:
        _videoPlayerController =
            VideoPlayerController.contentUri(Uri.parse(widget.videoUrl));

        break;
    }
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        placeholder: Image.asset(Assets.thumbNail),
        aspectRatio: 16 / 9,
        showControls: false,
        autoPlay: false);

    _listener() {}

    _videoPlayerController.addListener(_listener);
  }

  void videoUpdateNetwork() {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(_listener);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
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

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      widget.onFullScreenToggle(_isFullScreen);
      if (_isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeRight,
          DeviceOrientation.landscapeLeft,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlayPause,
      child: AspectRatio(
        aspectRatio:
            _isFullScreen ? MediaQuery.of(context).size.aspectRatio : 16 / 9,
        child: Center(
          child: Stack(fit: StackFit.expand, children: [
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
            Positioned(
              left: 16.0,
              bottom: 16.0,
              child: _videoPlayerController.value.isInitialized
                  ? Text(
                      '${_videoPlayerController.value.position.inMinutes}:${(_videoPlayerController.value.position.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      '00:00',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
            ),
            Positioned(
              bottom: 16.0,
              right: 48.0,
              child: _videoPlayerController.value.isInitialized
                  ? Text(
                      '${_videoPlayerController.value.duration.inMinutes}:${(_videoPlayerController.value.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      '00:00',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
            ),
            Positioned(
              right: 0,
              bottom: 3,
              child: IconButton(
                icon: Icon(
                  _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                  color: Colors.white,
                ),
                onPressed: _toggleFullScreen,
              ),
            ),
            Positioned(
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: Icon(
                  _videoPlayerController.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
