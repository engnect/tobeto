import 'dart:convert';

class EducationModel {
  final String educationId;
  final String userId;
  final String schoolName;
  final String schoolBranch;
  final String educationLevel;
  final DateTime schoolStartDate;
  final DateTime schoolEndDate;
  final bool? isCurrentlyStuding;
  EducationModel({
    required this.educationId,
    required this.userId,
    required this.schoolName,
    required this.schoolBranch,
    required this.educationLevel,
    required this.schoolStartDate,
    required this.schoolEndDate,
    this.isCurrentlyStuding,
  });

  EducationModel copyWith({
    String? educationId,
    String? userId,
    String? schoolName,
    String? schoolBranch,
    String? educationLevel,
    DateTime? schoolStartDate,
    DateTime? schoolEndDate,
    bool? isCurrentlyStuding,
  }) {
    return EducationModel(
      educationId: educationId ?? this.educationId,
      userId: userId ?? this.userId,
      schoolName: schoolName ?? this.schoolName,
      schoolBranch: schoolBranch ?? this.schoolBranch,
      educationLevel: educationLevel ?? this.educationLevel,
      schoolStartDate: schoolStartDate ?? this.schoolStartDate,
      schoolEndDate: schoolEndDate ?? this.schoolEndDate,
      isCurrentlyStuding: isCurrentlyStuding ?? this.isCurrentlyStuding,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'educationId': educationId,
      'userId': userId,
      'schoolName': schoolName,
      'schoolBranch': schoolBranch,
      'educationLevel': educationLevel,
      'schoolStartDate': schoolStartDate,
      'schoolEndDate': schoolEndDate,
      'isCurrentlyStuding': isCurrentlyStuding,
    };
  }

  factory EducationModel.fromMap(Map<String, dynamic> map) {
    return EducationModel(
      educationId: map['educationId'] ?? '',
      userId: map['userId'] ?? '',
      schoolName: map['schoolName'] ?? '',
      schoolBranch: map['schoolBranch'] ?? '',
      educationLevel: map['educationLevel'] ?? '',
      schoolStartDate: map['schoolStartDate'].toDate() ?? '',
      schoolEndDate: map['schoolEndDate'].toDate() ?? '',
      isCurrentlyStuding: map['isCurrentlyStuding'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EducationModel.fromJson(String source) =>
      EducationModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EducationModel(educationId: $educationId, userId: $userId, schoolName: $schoolName, schoolBranch: $schoolBranch, educationLevel: $educationLevel, schoolStartDate: $schoolStartDate, schoolEndDate: $schoolEndDate, isCurrentlyStuding: $isCurrentlyStuding)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EducationModel &&
        other.educationId == educationId &&
        other.userId == userId &&
        other.schoolName == schoolName &&
        other.schoolBranch == schoolBranch &&
        other.educationLevel == educationLevel &&
        other.schoolStartDate == schoolStartDate &&
        other.schoolEndDate == schoolEndDate &&
        other.isCurrentlyStuding == isCurrentlyStuding;
  }

  @override
  int get hashCode {
    return educationId.hashCode ^
        userId.hashCode ^
        schoolName.hashCode ^
        schoolBranch.hashCode ^
        educationLevel.hashCode ^
        schoolStartDate.hashCode ^
        schoolEndDate.hashCode ^
        isCurrentlyStuding.hashCode;
  }
}
