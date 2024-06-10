import 'package:flutter/material.dart';
import 'package:tobeto/src/data/datasource/course_fake_data.dart';
import 'package:tobeto/src/presentation/screens/course/course_screen_details.dart';
import 'package:tobeto/src/presentation/screens/course/widgets/course_card.dart';
import 'package:tobeto/src/presentation/widgets/tbt_app_bar_widget.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});
  // Course modeli oluşturup buraya çek

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

final controller = ScrollController();

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 240, 240, 240),
            appBar: TBTAppBar(controller: controller),
            body: SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: coursesWithModel.map((course) {
                    return CourseCard(
                      image: course.courseThumbnail,
                      date: course.startDate,
                      title: course.courseName,
                      ontap: () {
                        final courseVideos = coursesVideosWithModel
                            .where((video) =>
                                video.courseName == course.courseName)
                            .toList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseScreenDetails(
                                course: course, courseVideos: courseVideos),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ))));
  }
}
