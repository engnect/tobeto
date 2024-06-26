import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/models/course_video_model.dart';
import 'package:tobeto/src/presentation/screens/platform/widgets/course_video.dart';
import 'package:tobeto/src/presentation/screens/platform/widgets/course_video_card.dart';
import 'package:video_player/video_player.dart';

class CourseScreenDetails extends StatefulWidget {
  final CourseModel course;
  final List<CourseVideoModel> courseVideos;

  const CourseScreenDetails(
      {required this.course, required this.courseVideos, super.key});

  @override
  State<CourseScreenDetails> createState() => _CourseScreenDetailsState();
}

class _CourseScreenDetailsState extends State<CourseScreenDetails> {
  late String courseVideoUrl;
  bool _showAppBar = true;

  Future<double> _updateWatchedPercentage(String videoUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? percentage = prefs.getDouble('$videoUrl-watchedPercentage');
    return percentage ?? 0.0;
  }

  @override
  void initState() {
    super.initState();
    courseVideoUrl =
        widget.courseVideos.isNotEmpty ? widget.courseVideos[0].videoUrl : '';
  }

  void _onFullScreenToggle(bool isFullScreen) {
    setState(() {
      _showAppBar = !isFullScreen;
    });
  }

  void _updateVideoUrl(String newUrl) {
    setState(() {
      courseVideoUrl = newUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _showAppBar
            ? AppBar(
                title: Text(
                  widget.course.courseName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Platform.isIOS
                            ? CupertinoAlertDialog(
                                actions: [
                                  CupertinoDialogAction(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Kapat'),
                                    ),
                                  ),
                                ],
                                title: const Text('Ders Hakkında'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        'Başlangıç Tarihi: ${DateFormat('dd/MM/yyyy').format(widget.course.courseStartDate)}'),
                                    Text(
                                        'Bitiş Tarihi: ${DateFormat('dd/MM/yyyy').format(widget.course.courseEndDate)}'),
                                    Text(
                                        'Üretici Firma: ${widget.course.courseManufacturer}'),
                                  ],
                                ),
                              )
                            : AlertDialog(
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Kapat'),
                                  ),
                                ],
                                title: Text(
                                  'Ders Hakkında',
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Başlangıç Tarihi: ${DateFormat('dd/MM/yyyy').format(widget.course.courseStartDate)}',
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    Text(
                                      'Bitiş Tarihi: ${DateFormat('dd/MM/yyyy').format(widget.course.courseEndDate)}',
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    Text(
                                      'Üretici Firma: ${widget.course.courseManufacturer}',
                                      style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ],
                                ),
                                titleTextStyle: const TextStyle(
                                  fontSize: 36,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                contentTextStyle: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                      );
                    },
                    icon: const Icon(Icons.info_outline_rounded),
                  ),
                ],
              )
            : null,
        body: Column(
          children: [
            CourseVideo(
              dataSourceType: DataSourceType.network,
              videoUrl: courseVideoUrl,
              onFullScreenToggle: _onFullScreenToggle,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: widget.courseVideos.map((courseVideo) {
                    return FutureBuilder(
                      future: _updateWatchedPercentage(courseVideo.videoUrl),
                      builder: (BuildContext context,
                          AsyncSnapshot<double> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return CourseVideoCard(
                            courseVideo: courseVideo,
                            onTap: () => _updateVideoUrl(courseVideo.videoUrl),
                            watchedPercentage: snapshot.data!.roundToDouble(),
                            course: widget.course,
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
