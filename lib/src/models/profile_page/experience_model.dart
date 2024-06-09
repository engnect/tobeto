class ExperienceInfo {
  final String company;
  final String position;
  final String? experienceType;
  final String sector;
  final String city;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrentlyWorking;
  final String jobDescription;

  ExperienceInfo({
    required this.company,
    required this.position,
    this.experienceType,
    required this.sector,
    required this.city,
    this.startDate,
    this.endDate,
    required this.isCurrentlyWorking,
    required this.jobDescription,
  });
}
