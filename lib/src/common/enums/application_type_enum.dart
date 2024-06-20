enum ApplicationType {
  istanbulkodluyor,
  instructor,
  admin,
}

extension ApplicationTypeExtension on ApplicationType {
  static ApplicationType fromName(String name) {
    return ApplicationType.values.firstWhere((element) => element.name == name);
  }

  String toNameCapitalize() {
    return '${name[0].toUpperCase()}${name.substring(1)}';
  }
}
