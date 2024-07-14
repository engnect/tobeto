import 'dart:convert';

class StaffModel {
  final String staffId;
  final String staffFullName;
  final String staffTitle;
  final String staffAvatarUrl;
  StaffModel({
    required this.staffId,
    required this.staffFullName,
    required this.staffTitle,
    required this.staffAvatarUrl,
  });

  StaffModel copyWith({
    String? staffId,
    String? staffFullName,
    String? staffTitle,
    String? staffAvatarUrl,
  }) {
    return StaffModel(
      staffId: staffId ?? this.staffId,
      staffFullName: staffFullName ?? this.staffFullName,
      staffTitle: staffTitle ?? this.staffTitle,
      staffAvatarUrl: staffAvatarUrl ?? this.staffAvatarUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'staffId': staffId,
      'staffFullName': staffFullName,
      'staffTitle': staffTitle,
      'staffAvatarUrl': staffAvatarUrl,
    };
  }

  factory StaffModel.fromMap(Map<String, dynamic> map) {
    return StaffModel(
      staffId: map['staffId'] ?? '',
      staffFullName: map['staffFullName'] ?? '',
      staffTitle: map['staffTitle'] ?? '',
      staffAvatarUrl: map['staffAvatarUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StaffModel.fromJson(String source) =>
      StaffModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StaffModel(staffId: $staffId, staffFullName: $staffFullName, staffTitle: $staffTitle, staffAvatarUrl: $staffAvatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StaffModel &&
        other.staffId == staffId &&
        other.staffFullName == staffFullName &&
        other.staffTitle == staffTitle &&
        other.staffAvatarUrl == staffAvatarUrl;
  }

  @override
  int get hashCode {
    return staffId.hashCode ^
        staffFullName.hashCode ^
        staffTitle.hashCode ^
        staffAvatarUrl.hashCode;
  }
}
