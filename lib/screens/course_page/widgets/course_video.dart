import 'dart:async';
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
  late ChewieController? _chewieController;
  late VideoPlayerController _videoPlayerController;
  late VoidCallback _listener;
  bool _isFullScreen = false;
  bool _showControls = true;
  Timer? _hideControlsTimer;
  double _currentPlaybackSpeed = 1.0; // Current playback speed

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer(widget.videoUrl);
    _initializeChewieController();
    _startHideControlsTimer();
  }

  @override
  void didUpdateWidget(CourseVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _videoPlayerController.pause();
      _videoPlayerController.dispose();
      _initializeVideoPlayer(widget.videoUrl);
    }
    if (_chewieController != null) {
      _chewieController!.dispose(); // Dispose the previous ChewieController
      _initializeChewieController(); // Initialize a new ChewieController
    }
  }

  void _initializeVideoPlayer(String videoUrl) {
    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(videoUrl);
        break;
      case DataSourceType.network:
        _videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(videoUrl));
        break;
      case DataSourceType.file:
        _videoPlayerController = VideoPlayerController.file(File(videoUrl));
        break;
      case DataSourceType.contentUri:
        _videoPlayerController =
            VideoPlayerController.contentUri(Uri.parse(videoUrl));
        break;
    }
    _videoPlayerController.initialize().then((_) {
      setState(() {});
    });
    _listener() {
      setState(() {});
    }

    _videoPlayerController.addListener(_listener);
  }

  void _initializeChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      placeholder: Image.asset(Assets.thumbNail),
      aspectRatio: 16 / 9,
      showControls: false,
      autoPlay: false,
    );
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    _videoPlayerController.removeListener(_listener);
    _videoPlayerController.dispose();
    _chewieController?.dispose();
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

  void _startHideControlsTimer() {
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  void _resetHideControlsTimer() {
    if (!_showControls) {
      setState(() {
        _showControls = true;
      });
    }
    _hideControlsTimer?.cancel();
    _startHideControlsTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _resetHideControlsTimer();
      },
      onPanUpdate: (details) {
        _resetHideControlsTimer();
      },
      child: AspectRatio(
        aspectRatio:
            _isFullScreen ? MediaQuery.of(context).size.aspectRatio : 16 / 9,
        child: Center(
          child: Stack(fit: StackFit.expand, children: [
            Chewie(
              controller: _chewieController!,
            ),
            if (_showControls)
              Positioned(
                right: 0,
                top: 0,
                child: PopupMenuButton<double>(
                  icon: Icon(
                    Icons.slow_motion_video,
                    color: _isFullScreen ? Colors.black : Colors.white,
                  ),
                  onSelected: (speed) {
                    setState(() {
                      _currentPlaybackSpeed = speed;
                      _videoPlayerController.setPlaybackSpeed(speed);
                    });
                  },
                  itemBuilder: (context) =>
                      [0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0].map((speed) {
                    return PopupMenuItem<double>(
                      value: speed,
                      child: Container(
                        color: _currentPlaybackSpeed == speed
                            ? Colors.grey
                            : Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Text(
                          '${speed}x',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: _currentPlaybackSpeed == speed
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // PopupMenuButton<PlaybackSpeed>(
                //   icon: Icon(
                //     Icons.slow_motion_video_rounded,
                //     color: _isFullScreen ? Colors.black : Colors.white,
                //   ),
                //   iconColor: Colors.white,
                //   shadowColor: Colors.black,
                //   itemBuilder: (BuildContext context) {
                //     return _speedOptions.map((PlaybackSpeed speed) {
                //       return PopupMenuItem<PlaybackSpeed>(
                //         value: speed,
                //         child: Text(_getDisplayText(speed)),
                //       );
                //     }).toList();
                //   },
                //   onSelected: (PlaybackSpeed speed) {
                //     _changePlaybackSpeed(speed);
                //   },
                // ),
              ),
            if (_showControls)
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
            if (_showControls)
              // Video current time
              Positioned(
                left: 16.0,
                bottom: 16.0,
                child: _videoPlayerController.value.isInitialized
                    ? Text(
                        '${_videoPlayerController.value.position.inMinutes}:${(_videoPlayerController.value.position.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      )
                    : const Text(
                        '00:00',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      ),
              ),
            if (_showControls)
              // Video total duration
              Positioned(
                bottom: 16.0,
                right: 48.0,
                child: _videoPlayerController.value.isInitialized
                    ? Text(
                        '${_videoPlayerController.value.duration.inMinutes}:${(_videoPlayerController.value.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      )
                    : const Text(
                        '00:00',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 2.0,
                              color: Colors.black,
                              offset: Offset(1.0, 1.0),
                            ),
                          ],
                        ),
                      ),
              ),
            if (_showControls)
              Positioned(
                right: 0,
                bottom: 2,
                child: IconButton(
                  icon: Icon(
                    _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: _isFullScreen ? Colors.black : Colors.white,
                  ),
                  onPressed: _toggleFullScreen,
                ),
              ),
            if (_showControls)
              Positioned(
                child: GestureDetector(
                  onTap: _togglePlayPause,
                  child: Icon(
                    _videoPlayerController.value.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    size: 100,
                    color: _isFullScreen
                        ? const Color.fromARGB(255, 105, 105, 105)
                        : Colors.white,
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }
}
