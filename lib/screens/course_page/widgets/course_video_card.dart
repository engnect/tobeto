import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseVideoCard extends StatelessWidget {
  final Map<String, String> course;
  final VoidCallback onTap;
  const CourseVideoCard({
    required this.course,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course['CourseName']!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Instructor: ${course['CourseInstructor']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
