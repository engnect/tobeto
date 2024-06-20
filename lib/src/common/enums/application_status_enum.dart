enum ApplicationStatus { waiting, approved, denied }

extension ApplicationStatusExtension on ApplicationStatus {
  static ApplicationStatus fromName(String name) {
    return ApplicationStatus.values
        .firstWhere((element) => element.name == name);
  }

  String toNameCapitalize() {
    return '${name[0].toUpperCase()}${name.substring(1)}';
  }
}
