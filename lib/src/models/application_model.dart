import 'dart:convert';
import 'package:tobeto/src/common/enums/application_type_enum.dart';

class ApplicationModel {
  final String applicationId;
  final String userId;
  final String applicationContent;
  // enum
  final ApplicationType applicationType;

  final bool didApplicationApproved;
  final DateTime applicationCreatedAt;
  final String applicationClosedBy;
  final DateTime applicationClosedAt;
  ApplicationModel({
    required this.applicationId,
    required this.userId,
    required this.applicationContent,
    required this.applicationType,
    required this.didApplicationApproved,
    required this.applicationCreatedAt,
    required this.applicationClosedBy,
    required this.applicationClosedAt,
  });

  ApplicationModel copyWith({
    String? applicationId,
    String? userId,
    String? applicationContent,
    ApplicationType? applicationType,
    bool? didApplicationApproved,
    DateTime? applicationCreatedAt,
    String? applicationClosedBy,
    DateTime? applicationClosedAt,
  }) {
    return ApplicationModel(
      applicationId: applicationId ?? this.applicationId,
      userId: userId ?? this.userId,
      applicationContent: applicationContent ?? this.applicationContent,
      applicationType: applicationType ?? this.applicationType,
      didApplicationApproved:
          didApplicationApproved ?? this.didApplicationApproved,
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
      'didApplicationApproved': didApplicationApproved,
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
      didApplicationApproved: map['didApplicationApproved'] ?? false,
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
    return 'ApplicationModel(applicationId: $applicationId, userId: $userId, applicationContent: $applicationContent, applicationType: $applicationType, didApplicationApproved: $didApplicationApproved, applicationCreatedAt: $applicationCreatedAt, applicationClosedBy: $applicationClosedBy, applicationClosedAt: $applicationClosedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApplicationModel &&
        other.applicationId == applicationId &&
        other.userId == userId &&
        other.applicationContent == applicationContent &&
        other.applicationType == applicationType &&
        other.didApplicationApproved == didApplicationApproved &&
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
        didApplicationApproved.hashCode ^
        applicationCreatedAt.hashCode ^
        applicationClosedBy.hashCode ^
        applicationClosedAt.hashCode;
  }
}
