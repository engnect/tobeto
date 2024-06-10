import 'dart:convert';

class ExperienceModel {
  final String experienceId;
  final String userId;
  final String companyName;
  final String experiencePosition;
  final String experienceType;
  final String experienceSector;
  final String experienceCity;
  final DateTime startDate;
  final DateTime endDate;
  final bool? isCurrentlyWorking;
  final String? jobDescription;
  ExperienceModel({
    required this.experienceId,
    required this.userId,
    required this.companyName,
    required this.experiencePosition,
    required this.experienceType,
    required this.experienceSector,
    required this.experienceCity,
    required this.startDate,
    required this.endDate,
    this.isCurrentlyWorking,
    this.jobDescription,
  });

  ExperienceModel copyWith({
    String? experienceId,
    String? userId,
    String? companyName,
    String? experiencePosition,
    String? experienceType,
    String? experienceSector,
    String? experienceCity,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyWorking,
    String? jobDescription,
  }) {
    return ExperienceModel(
      experienceId: experienceId ?? this.experienceId,
      userId: userId ?? this.userId,
      companyName: companyName ?? this.companyName,
      experiencePosition: experiencePosition ?? this.experiencePosition,
      experienceType: experienceType ?? this.experienceType,
      experienceSector: experienceSector ?? this.experienceSector,
      experienceCity: experienceCity ?? this.experienceCity,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentlyWorking: isCurrentlyWorking ?? this.isCurrentlyWorking,
      jobDescription: jobDescription ?? this.jobDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'experienceId': experienceId,
      'userId': userId,
      'companyName': companyName,
      'experiencePosition': experiencePosition,
      'experienceType': experienceType,
      'experienceSector': experienceSector,
      'experienceCity': experienceCity,
      'startDate': startDate,
      'endDate': endDate,
      'isCurrentlyWorking': isCurrentlyWorking,
      'jobDescription': jobDescription,
    };
  }

  factory ExperienceModel.fromMap(Map<String, dynamic> map) {
    return ExperienceModel(
      experienceId: map['experienceId'] ?? '',
      userId: map['userId'] ?? '',
      companyName: map['companyName'] ?? '',
      experiencePosition: map['experiencePosition'] ?? '',
      experienceType: map['experienceType'] ?? '',
      experienceSector: map['experienceSector'] ?? '',
      experienceCity: map['experienceCity'] ?? '',
      startDate: map['startDate'].toDate() ?? '',
      endDate: map['endDate'].toDate() ?? '',
      isCurrentlyWorking: map['isCurrentlyWorking'],
      jobDescription: map['jobDescription'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExperienceModel.fromJson(String source) =>
      ExperienceModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExperienceModel(experienceId: $experienceId, userId: $userId, companyName: $companyName, experiencePosition: $experiencePosition, experienceType: $experienceType, experienceSector: $experienceSector, experienceCity: $experienceCity, startDate: $startDate, endDate: $endDate, isCurrentlyWorking: $isCurrentlyWorking, jobDescription: $jobDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExperienceModel &&
        other.experienceId == experienceId &&
        other.userId == userId &&
        other.companyName == companyName &&
        other.experiencePosition == experiencePosition &&
        other.experienceType == experienceType &&
        other.experienceSector == experienceSector &&
        other.experienceCity == experienceCity &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.isCurrentlyWorking == isCurrentlyWorking &&
        other.jobDescription == jobDescription;
  }

  @override
  int get hashCode {
    return experienceId.hashCode ^
        userId.hashCode ^
        companyName.hashCode ^
        experiencePosition.hashCode ^
        experienceType.hashCode ^
        experienceSector.hashCode ^
        experienceCity.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        isCurrentlyWorking.hashCode ^
        jobDescription.hashCode;
  }
}
