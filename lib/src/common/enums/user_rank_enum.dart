enum UserRank { student, instructor, admin }

extension UserRankExtension on UserRank {
  static UserRank fromName(String name) {
    return UserRank.values.firstWhere((element) => element.name == name);
  }

  String toNameCapitalize() {
    return '${name[0].toUpperCase()}${name.substring(1)}';
  }
}
