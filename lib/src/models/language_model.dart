import 'dart:convert';

class LanguageModel {
  final String? languageId;
  final String? userId;
  final String? languageName;
  final String? languageLevel;
  LanguageModel({
    this.languageId,
    this.userId,
    this.languageName,
    this.languageLevel,
  });

  LanguageModel copyWith({
    String? languageId,
    String? userId,
    String? languageName,
    String? languageLevel,
  }) {
    return LanguageModel(
      languageId: languageId ?? this.languageId,
      userId: userId ?? this.userId,
      languageName: languageName ?? this.languageName,
      languageLevel: languageLevel ?? this.languageLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'languageId': languageId,
      'userId': userId,
      'languageName': languageName,
      'languageLevel': languageLevel,
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      languageId: map['languageId'],
      userId: map['userId'],
      languageName: map['languageName'],
      languageLevel: map['languageLevel'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LanguageModel.fromJson(String source) =>
      LanguageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LanguageModel(languageId: $languageId, userId: $userId, languageName: $languageName, languageLevel: $languageLevel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LanguageModel &&
        other.languageId == languageId &&
        other.userId == userId &&
        other.languageName == languageName &&
        other.languageLevel == languageLevel;
  }

  @override
  int get hashCode {
    return languageId.hashCode ^
        userId.hashCode ^
        languageName.hashCode ^
        languageLevel.hashCode;
  }
}
