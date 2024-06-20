import 'dart:convert';

class CourseVideoModel {
  final String videoId;
  final String courseId;
  final String courseVideoName;
  final String courseName;
  final String videoUrl;

  CourseVideoModel({
    required this.videoId,
    required this.courseId,
    required this.courseVideoName,
    required this.courseName,
    required this.videoUrl,
  });

  CourseVideoModel copyWith({
    String? courseId,
    String? courseVideoName,
    String? courseName,
    String? videoUrl,
  }) {
    return CourseVideoModel(
      courseId: courseId ?? this.courseId,
      courseVideoName: courseVideoName ?? this.courseVideoName,
      courseName: courseName ?? this.courseName,
      videoUrl: videoUrl ?? this.videoUrl,
      videoId: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'courseVideoName': courseVideoName,
      'courseName': courseName,
      'videoUrl': videoUrl,
    };
  }

  factory CourseVideoModel.fromMap(Map<String, dynamic> map) {
    return CourseVideoModel(
      courseId: map['courseId'] ?? '',
      courseVideoName: map['courseVideoName'] ?? '',
      courseName: map['courseName'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      videoId: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseVideoModel.fromJson(String source) =>
      CourseVideoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CourseVideoModel(courseId: $courseId, courseVideoName: $courseVideoName, courseName: $courseName, videoUrl: $videoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseVideoModel &&
        other.courseId == courseId &&
        other.courseVideoName == courseVideoName &&
        other.courseName == courseName &&
        other.videoUrl == videoUrl;
  }

  @override
  int get hashCode {
    return courseId.hashCode ^
        courseVideoName.hashCode ^
        courseName.hashCode ^
        videoUrl.hashCode;
  }
}
