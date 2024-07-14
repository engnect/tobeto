import 'dart:convert';
import 'package:flutter/foundation.dart';

class CourseVideoModel {
  final String videoId;
  final String courseId;
  final String courseVideoName;
  final String courseName;
  final String videoUrl;
  final Map<String, double>? percentageOfWatchedVideosByUsers;

  CourseVideoModel({
    required this.videoId,
    required this.courseId,
    required this.courseVideoName,
    required this.courseName,
    required this.videoUrl,
    this.percentageOfWatchedVideosByUsers,
  });

  CourseVideoModel copyWith({
    String? videoId,
    String? courseId,
    String? courseVideoName,
    String? courseName,
    String? videoUrl,
    Map<String, double>? percentageOfWatchedVideosByUsers,
  }) {
    return CourseVideoModel(
      videoId: videoId ?? this.videoId,
      courseId: courseId ?? this.courseId,
      courseVideoName: courseVideoName ?? this.courseVideoName,
      courseName: courseName ?? this.courseName,
      videoUrl: videoUrl ?? this.videoUrl,
      percentageOfWatchedVideosByUsers: percentageOfWatchedVideosByUsers ??
          this.percentageOfWatchedVideosByUsers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'courseId': courseId,
      'courseVideoName': courseVideoName,
      'courseName': courseName,
      'videoUrl': videoUrl,
      'percentageOfWatchedVideosByUsers': percentageOfWatchedVideosByUsers,
    };
  }

  factory CourseVideoModel.fromMap(Map<String, dynamic> map) {
    return CourseVideoModel(
      videoId: map['videoId'] ?? '',
      courseId: map['courseId'] ?? '',
      courseVideoName: map['courseVideoName'] ?? '',
      courseName: map['courseName'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      percentageOfWatchedVideosByUsers: Map<String, double>.from(
          map['percentageOfWatchedVideosByUsers'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseVideoModel.fromJson(String source) =>
      CourseVideoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CourseVideoModel(videoId: $videoId, courseId: $courseId, courseVideoName: $courseVideoName, courseName: $courseName, videoUrl: $videoUrl, percentageOfWatchedVideosByUsers: $percentageOfWatchedVideosByUsers,)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseVideoModel &&
        other.videoId == videoId &&
        other.courseId == courseId &&
        other.courseVideoName == courseVideoName &&
        other.courseName == courseName &&
        other.videoUrl == videoUrl &&
        mapEquals(other.percentageOfWatchedVideosByUsers,
            percentageOfWatchedVideosByUsers);
  }

  @override
  int get hashCode {
    return videoId.hashCode ^
        courseId.hashCode ^
        courseVideoName.hashCode ^
        courseName.hashCode ^
        videoUrl.hashCode ^
        percentageOfWatchedVideosByUsers.hashCode;
  }
}
