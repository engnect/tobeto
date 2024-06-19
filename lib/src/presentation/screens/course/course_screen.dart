import 'package:flutter/material.dart';
import 'package:tobeto/src/domain/repositories/course_repository.dart';
import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/presentation/screens/course/course_screen_details.dart';
import 'package:tobeto/src/presentation/screens/course/widgets/course_card.dart';
import 'package:tobeto/src/presentation/widgets/tbt_sliver_app_bar.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});
  // Course modeli oluşturup buraya çek

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  final CourseRepository _courseRepository = CourseRepository();
  late Future<List<CourseModel>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = _courseRepository.fetchAllCourses();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        body: CustomScrollView(
          slivers: [
            const TBTSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  FutureBuilder<List<CourseModel>>(
                    future: _coursesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No courses available.'));
                      } else {
                        return Column(
                          children: snapshot.data!.map((course) {
                            return CourseCard(
                              image: course.courseThumbnail,
                              date: course.startDate,
                              title: course.courseName,
                              ontap: () async {
                                final courseVideos = await _courseRepository
                                    .fetchCourseVideos(course.courseId);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CourseScreenDetails(
                                      course: course,
                                      courseVideos: courseVideos,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
