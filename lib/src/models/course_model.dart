import 'dart:convert';

class CourseModel {
  final String courseThumbnail;
  final String courseName;
  final String startDate;
  CourseModel({
    required this.courseThumbnail,
    required this.courseName,
    required this.startDate,
  });

  CourseModel copyWith({
    String? courseThumbnail,
    String? courseName,
    String? startDate,
  }) {
    return CourseModel(
      courseThumbnail: courseThumbnail ?? this.courseThumbnail,
      courseName: courseName ?? this.courseName,
      startDate: startDate ?? this.startDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseThumbnail': courseThumbnail,
      'courseName': courseName,
      'startDate': startDate,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      courseThumbnail: map['courseThumbnail'] ?? '',
      courseName: map['courseName'] ?? '',
      startDate: map['startDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CourseModel(courseThumbnail: $courseThumbnail, courseName: $courseName, startDate: $startDate)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseModel &&
        other.courseThumbnail == courseThumbnail &&
        other.courseName == courseName &&
        other.startDate == startDate;
  }

  @override
  int get hashCode =>
      courseThumbnail.hashCode ^ courseName.hashCode ^ startDate.hashCode;
}
