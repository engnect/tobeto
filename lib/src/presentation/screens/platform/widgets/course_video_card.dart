import 'package:flutter/material.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/course_model.dart';
import 'package:tobeto/src/models/course_video_model.dart';
import 'package:tobeto/src/models/user_model.dart';

class CourseVideoCard extends StatefulWidget {
  final CourseVideoModel courseVideo;
  final CourseModel course;
  final VoidCallback onTap;
  final double? watchedPercentage; // Yeni eklenen watchedPercentage

  const CourseVideoCard({
    required this.course,
    required this.courseVideo,
    required this.watchedPercentage,
    required this.onTap,
    super.key,
  });

  @override
  State<CourseVideoCard> createState() => _CourseVideoCardState();
}

class _CourseVideoCardState extends State<CourseVideoCard> {
  String instructorNames = '';

  @override
  void initState() {
    super.initState();
    getInstructorNames();
  }

  void getInstructorNames() async {
    for (var i = 0; i < widget.course.courseInstructorsIds.length; i++) {
      UserModel? userModel = await UserRepository()
          .getSpecificUserById(widget.course.courseInstructorsIds[i]!);

      instructorNames +=
          ('\n - ${userModel!.userName} ${userModel.userSurname}');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Theme.of(context).colorScheme.background,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.courseVideo.courseVideoName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Text(
                      'Eğitmenler: ${instructorNames.toString()}',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                if (widget.watchedPercentage != null &&
                    widget.watchedPercentage! > 0 &&
                    widget.watchedPercentage! < 100)
                  const Icon(
                    Icons.watch_later,
                    color: Colors.grey,
                  )
                else if (widget.watchedPercentage == 100)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
