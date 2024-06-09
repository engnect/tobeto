class EducationInfo {
  final String university;
  final String department;
  final String? educationLevel;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrentlyStudied;

  EducationInfo({
    required this.university,
    required this.department,
    this.educationLevel,
    this.startDate,
    this.endDate,
    required this.isCurrentlyStudied,
  });
}
