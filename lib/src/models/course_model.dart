import 'dart:convert';

import 'package:flutter/foundation.dart';

class CourseModel {
  final String courseId;
  final String courseThumbnail;
  final String courseName;
  final String startDate;
  final String endDate;
  final String estimatedTime;
  final String manufacturer;
  final List<String> courseInstructors;
  CourseModel({
    required this.courseId,
    required this.courseThumbnail,
    required this.courseName,
    required this.startDate,
    required this.endDate,
    required this.estimatedTime,
    required this.manufacturer,
    required this.courseInstructors,
  });

  CourseModel copyWith({
    String? courseId,
    String? courseThumbnail,
    String? courseName,
    String? startDate,
    String? endDate,
    String? estimatedTime,
    String? manufacturer,
    List<String>? courseInstructors,
  }) {
    return CourseModel(
      courseId: courseId ?? this.courseId,
      courseThumbnail: courseThumbnail ?? this.courseThumbnail,
      courseName: courseName ?? this.courseName,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      manufacturer: manufacturer ?? this.manufacturer,
      courseInstructors: courseInstructors ?? this.courseInstructors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'courseThumbnail': courseThumbnail,
      'courseName': courseName,
      'startDate': startDate,
      'endDate': endDate,
      'estimatedTime': estimatedTime,
      'manufacturer': manufacturer,
      'courseInstructors': courseInstructors,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      courseId: map['courseId'] ?? '',
      courseThumbnail: map['courseThumbnail'] ?? '',
      courseName: map['courseName'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      estimatedTime: map['estimatedTime'] ?? '',
      manufacturer: map['manufacturer'] ?? '',
      courseInstructors: List<String>.from(map['courseInstructors']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CourseModel(courseId: $courseId, courseThumbnail: $courseThumbnail, courseName: $courseName, startDate: $startDate, endDate: $endDate, estimatedTime: $estimatedTime, manufacturer: $manufacturer, courseInstructors: $courseInstructors)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseModel &&
        other.courseId == courseId &&
        other.courseThumbnail == courseThumbnail &&
        other.courseName == courseName &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.estimatedTime == estimatedTime &&
        other.manufacturer == manufacturer &&
        listEquals(other.courseInstructors, courseInstructors);
  }

  @override
  int get hashCode {
    return courseId.hashCode ^
        courseThumbnail.hashCode ^
        courseName.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        estimatedTime.hashCode ^
        manufacturer.hashCode ^
        courseInstructors.hashCode;
  }
}
