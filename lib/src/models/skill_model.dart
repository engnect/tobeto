import 'dart:convert';

class SkillModel {
  final String? skillId;
  final String? userId;
  final String? skillName;
  SkillModel({
    this.skillId,
    this.userId,
    this.skillName,
  });

  SkillModel copyWith({
    String? skillId,
    String? userId,
    String? skillName,
  }) {
    return SkillModel(
      skillId: skillId ?? this.skillId,
      userId: userId ?? this.userId,
      skillName: skillName ?? this.skillName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'skillId': skillId,
      'userId': userId,
      'skillName': skillName,
    };
  }

  factory SkillModel.fromMap(Map<String, dynamic> map) {
    return SkillModel(
      skillId: map['skillId'],
      userId: map['userId'],
      skillName: map['skillName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SkillModel.fromJson(String source) =>
      SkillModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SkillModel(skillId: $skillId, userId: $userId, skillName: $skillName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SkillModel &&
        other.skillId == skillId &&
        other.userId == userId &&
        other.skillName == skillName;
  }

  @override
  int get hashCode => skillId.hashCode ^ userId.hashCode ^ skillName.hashCode;
}
