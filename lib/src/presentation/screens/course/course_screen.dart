import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final ScrollController _controller = ScrollController();

  final CourseRepository _courseRepository = CourseRepository();
  late Stream<List<CourseModel>> _coursesStream;
  @override
  void initState() {
    super.initState();
    _coursesStream = _courseRepository.fetchAllCourses();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                delegate: SliverChildListDelegate([
              StreamBuilder<List<CourseModel>>(
                stream: _coursesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No courses available.'));
                  } else {
                    return Column(
                      children: snapshot.data!.map((course) {
                        return CourseCard(
                          image: course.courseThumbnailUrl,
                          date: DateFormat('dd/MM/yyyy')
                              .format(course.courseStartDate),
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
            ]))
          ],
        ),
      ),
    );
  }
}
