import 'dart:io';
import 'package:tobeto/data/course_fake_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tobeto/screens/course_page/widgets/course_video.dart';
import 'package:tobeto/screens/course_page/widgets/course_video_card.dart';
import 'package:video_player/video_player.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final String courseVideoUrl =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seçili Dersin Adı'),
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
                                    child: const Text('Kapat')),
                              )
                            ],
                            title: const Text('Ders Hakkında'),
                            content: const Text(
                                'Başlangıç \${course.startDate}\nBitiş \${course.endDate}\nTahmini Süre \${course.estimatedTime}\nÜretici Firma \${course.company}'),
                          )
                        : AlertDialog(
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Kapat'),
                              )
                            ],
                            title: const Text('Ders Hakkında'),
                            content: const Text(
                                'Başlangıç \${course.startDate}\nBitiş \${course.endDate}\nTahmini Süre \${course.estimatedTime}\nÜretici Firma \${course.company}'),
                            titleTextStyle: const TextStyle(
                                fontSize: 36,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            contentTextStyle: const TextStyle(
                                fontSize: 24, color: Colors.black),
                          ),
                  );
                },
                icon: const Icon(Icons.info_outline_rounded))
          ],
        ),
        body: Column(
          children: [
            CourseVideo(
              dataSourceType: DataSourceType.network,
              videoUrl: courseVideoUrl,
            ),
            Expanded(
              child: Container(
                height: 800,
                color: Colors.lightBlueAccent,
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: courses.map((course) {
                        return CourseVideoCard(course: course);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
