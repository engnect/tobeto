import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/export_domain.dart';
import '../../../../models/export_models.dart';
import '../../../widgets/export_widgets.dart';
import '../../export_screens.dart';

class CourseTabScreen extends StatefulWidget {
  const CourseTabScreen({super.key});

  @override
  State<CourseTabScreen> createState() => _CourseTabScreenState();
}

class _CourseTabScreenState extends State<CourseTabScreen> {
  final ScrollController _controller = ScrollController();

  final CourseRepository _courseRepository = CourseRepository();
  late Stream<List<CourseModel>> _coursesStream;
  @override
  void initState() {
    super.initState();
    _coursesStream = _courseRepository.fetchAllCoursesAsStream();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const TBTDrawer(),
      endDrawer: const TBTEndDrawer(),
      body: CustomScrollView(
        slivers: [
          const TBTSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                StreamBuilder<List<CourseModel>>(
                  stream: _coursesStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          'No courses available.',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      );
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
                              if (!context.mounted) return;
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
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
