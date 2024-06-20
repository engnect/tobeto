import 'dart:convert';

import 'package:tobeto/src/common/enums/application_status_enum.dart';
import 'package:tobeto/src/common/enums/application_type_enum.dart';
import 'package:tobeto/src/common/enums/user_rank_enum.dart';

class ApplicationModel {
  final String applicationId;
  final String userId;
  final String applicationContent;
  // enum
  final ApplicationType applicationType;
  //enum
  final UserRank userRank;
  //enum
  final ApplicationStatus applicationStatus;

  final DateTime applicationCreatedAt;
  final String applicationClosedBy;
  final DateTime applicationClosedAt;
  ApplicationModel({
    required this.applicationId,
    required this.userId,
    required this.applicationContent,
    required this.applicationType,
    required this.userRank,
    required this.applicationStatus,
    required this.applicationCreatedAt,
    required this.applicationClosedBy,
    required this.applicationClosedAt,
  });

  ApplicationModel copyWith({
    String? applicationId,
    String? userId,
    String? applicationContent,
    ApplicationType? applicationType,
    UserRank? userRank,
    ApplicationStatus? applicationStatus,
    DateTime? applicationCreatedAt,
    String? applicationClosedBy,
    DateTime? applicationClosedAt,
  }) {
    return ApplicationModel(
      applicationId: applicationId ?? this.applicationId,
      userId: userId ?? this.userId,
      applicationContent: applicationContent ?? this.applicationContent,
      applicationType: applicationType ?? this.applicationType,
      userRank: userRank ?? this.userRank,
      applicationStatus: applicationStatus ?? this.applicationStatus,
      applicationCreatedAt: applicationCreatedAt ?? this.applicationCreatedAt,
      applicationClosedBy: applicationClosedBy ?? this.applicationClosedBy,
      applicationClosedAt: applicationClosedAt ?? this.applicationClosedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'applicationId': applicationId,
      'userId': userId,
      'applicationContent': applicationContent,
      'applicationType': applicationType.index,
      'userRank': userRank.index,
      'applicationStatus': applicationStatus.index,
      'applicationCreatedAt': applicationCreatedAt,
      'applicationClosedBy': applicationClosedBy,
      'applicationClosedAt': applicationClosedAt,
    };
  }

  factory ApplicationModel.fromMap(Map<String, dynamic> map) {
    return ApplicationModel(
      applicationId: map['applicationId'] ?? '',
      userId: map['userId'] ?? '',
      applicationContent: map['applicationContent'] ?? '',
      applicationType: ApplicationType.values[map['applicationType'] ?? 0],
      userRank: UserRank.values[map['userRank'] ?? 0],
      applicationStatus:
          ApplicationStatus.values[map['applicationStatus'] ?? 0],
      applicationCreatedAt:
          map['applicationCreatedAt'].toDate() ?? DateTime.now(),
      applicationClosedBy: map['applicationClosedBy'] ?? '',
      applicationClosedAt:
          map['applicationClosedAt'].toDate() ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplicationModel.fromJson(String source) =>
      ApplicationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ApplicationModel(applicationId: $applicationId, userId: $userId, applicationContent: $applicationContent, applicationType: $applicationType, userRank: $userRank, applicationStatus: $applicationStatus, applicationCreatedAt: $applicationCreatedAt, applicationClosedBy: $applicationClosedBy, applicationClosedAt: $applicationClosedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApplicationModel &&
        other.applicationId == applicationId &&
        other.userId == userId &&
        other.applicationContent == applicationContent &&
        other.applicationType == applicationType &&
        other.userRank == userRank &&
        other.applicationStatus == applicationStatus &&
        other.applicationCreatedAt == applicationCreatedAt &&
        other.applicationClosedBy == applicationClosedBy &&
        other.applicationClosedAt == applicationClosedAt;
  }

  @override
  int get hashCode {
    return applicationId.hashCode ^
        userId.hashCode ^
        applicationContent.hashCode ^
        applicationType.hashCode ^
        userRank.hashCode ^
        applicationStatus.hashCode ^
        applicationCreatedAt.hashCode ^
        applicationClosedBy.hashCode ^
        applicationClosedAt.hashCode;
  }
}
