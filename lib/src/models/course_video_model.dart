import 'dart:convert';

class CourseVideoModel {
  final String courseVideoName;
  final String courseName;
  final String startDate;
  final String endDate;
  final String estimatedDate;
  final String manufacturer;
  final String videoUrl;
  final String courseInstructor;
  CourseVideoModel(
      {required this.courseVideoName,
      required this.courseName,
      required this.startDate,
      required this.endDate,
      required this.estimatedDate,
      required this.manufacturer,
      required this.videoUrl,
      required this.courseInstructor});

  CourseVideoModel copyWith({
    String? courseVideoName,
    String? startDate,
    String? endDate,
    String? estimatedDate,
    String? manufacturer,
    String? videoUrl,
    String? courseInstructor,
  }) {
    return CourseVideoModel(
      courseVideoName: courseVideoName ?? this.courseVideoName,
      courseName: courseName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      estimatedDate: estimatedDate ?? this.estimatedDate,
      manufacturer: manufacturer ?? this.manufacturer,
      videoUrl: videoUrl ?? this.videoUrl,
      courseInstructor: courseInstructor ?? this.courseInstructor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseVideoName': courseVideoName,
      'startDate': startDate,
      'endDate': endDate,
      'estimatedDate': estimatedDate,
      'manufacturer': manufacturer,
      'videoUrl': videoUrl,
      'courseInstructor': courseInstructor,
    };
  }

  factory CourseVideoModel.fromMap(Map<String, dynamic> map) {
    return CourseVideoModel(
      courseVideoName: map['courseVideoName'] ?? '',
      courseName: map['courseName'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      estimatedDate: map['estimatedDate'] ?? '',
      manufacturer: map['manufacturer'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      courseInstructor: map['courseInstructor'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseVideoModel.fromJson(String source) =>
      CourseVideoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CourseVideoModel(courseVideoName: $courseVideoName, startDate: $startDate, endDate: $endDate, estimatedDate: $estimatedDate, manufacturer: $manufacturer, videoUrl: $videoUrl, courseInstructor: $courseInstructor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseVideoModel &&
        other.courseVideoName == courseVideoName &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.estimatedDate == estimatedDate &&
        other.manufacturer == manufacturer &&
        other.videoUrl == videoUrl &&
        other.courseInstructor == courseInstructor;
  }

  @override
  int get hashCode {
    return courseVideoName.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        estimatedDate.hashCode ^
        manufacturer.hashCode ^
        videoUrl.hashCode ^
        courseInstructor.hashCode;
  }
}
