import 'dart:convert';

import 'package:flutter/foundation.dart';

class CourseModel {
  final String courseId;
  final String courseThumbnailUrl;
  final String courseName;
  final DateTime courseStartDate;
  final DateTime courseEndDate;

  final String courseManufacturer;
  final List<String?> courseInstructorsIds;
  CourseModel({
    required this.courseId,
    required this.courseThumbnailUrl,
    required this.courseName,
    required this.courseStartDate,
    required this.courseEndDate,
    required this.courseManufacturer,
    required this.courseInstructorsIds,
  });

  CourseModel copyWith({
    String? courseId,
    String? courseThumbnailUrl,
    String? courseName,
    DateTime? courseStartDate,
    DateTime? courseEndDate,
    String? courseManufacturer,
    List<String?>? courseInstructorsIds,
  }) {
    return CourseModel(
      courseId: courseId ?? this.courseId,
      courseThumbnailUrl: courseThumbnailUrl ?? this.courseThumbnailUrl,
      courseName: courseName ?? this.courseName,
      courseStartDate: courseStartDate ?? this.courseStartDate,
      courseEndDate: courseEndDate ?? this.courseEndDate,
      courseManufacturer: courseManufacturer ?? this.courseManufacturer,
      courseInstructorsIds: courseInstructorsIds ?? this.courseInstructorsIds,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'courseThumbnailUrl': courseThumbnailUrl,
      'courseName': courseName,
      'courseStartDate': courseStartDate,
      'courseEndDate': courseEndDate,
      'courseManufacturer': courseManufacturer,
      'courseInstructorsIds': courseInstructorsIds,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      courseId: map['courseId'] ?? '',
      courseThumbnailUrl: map['courseThumbnailUrl'] ?? '',
      courseName: map['courseName'] ?? '',
      courseStartDate: map['courseStartDate'].toDate() ?? DateTime.now(),
      courseEndDate: map['courseEndDate'].toDate() ?? DateTime.now(),
      courseManufacturer: map['courseManufacturer'] ?? '',
      courseInstructorsIds: List<String?>.from(map['courseInstructorsIds']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CourseModel(courseId: $courseId, courseThumbnailUrl: $courseThumbnailUrl, courseName: $courseName, courseStartDate: $courseStartDate, courseEndDate: $courseEndDate, courseManufacturer: $courseManufacturer, courseInstructorsIds: $courseInstructorsIds)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseModel &&
        other.courseId == courseId &&
        other.courseThumbnailUrl == courseThumbnailUrl &&
        other.courseName == courseName &&
        other.courseStartDate == courseStartDate &&
        other.courseEndDate == courseEndDate &&
        other.courseManufacturer == courseManufacturer &&
        listEquals(other.courseInstructorsIds, courseInstructorsIds);
  }

  @override
  int get hashCode {
    return courseId.hashCode ^
        courseThumbnailUrl.hashCode ^
        courseName.hashCode ^
        courseStartDate.hashCode ^
        courseEndDate.hashCode ^
        courseManufacturer.hashCode ^
        courseInstructorsIds.hashCode;
  }
}
