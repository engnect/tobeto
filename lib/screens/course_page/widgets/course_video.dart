import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/constants/assets.dart';
import 'package:video_player/video_player.dart';

class CourseVideo extends StatefulWidget {
  const CourseVideo(
      {super.key, required this.dataSourceType, required this.videoUrl});

  final DataSourceType dataSourceType;
  final String videoUrl;

  @override
  State<CourseVideo> createState() => _CourseVideoState();
}

class _CourseVideoState extends State<CourseVideo> {
  late ChewieController _chewieController;
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.videoUrl);
        break;
      case DataSourceType.network:
        _videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
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
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}
