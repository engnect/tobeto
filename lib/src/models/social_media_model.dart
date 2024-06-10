import 'dart:convert';

class SocialMediaModel {
  final String? socialMediaId;
  final String? userId;
  final String socialMediaPlatform;
  final String socialMedialink;
  SocialMediaModel({
    this.socialMediaId,
    this.userId,
    required this.socialMediaPlatform,
    required this.socialMedialink,
  });

  SocialMediaModel copyWith({
    String? socialMediaId,
    String? userId,
    String? socialMediaPlatform,
    String? socialMedialink,
  }) {
    return SocialMediaModel(
      socialMediaId: socialMediaId ?? this.socialMediaId,
      userId: userId ?? this.userId,
      socialMediaPlatform: socialMediaPlatform ?? this.socialMediaPlatform,
      socialMedialink: socialMedialink ?? this.socialMedialink,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'socialMediaId': socialMediaId,
      'userId': userId,
      'socialMediaPlatform': socialMediaPlatform,
      'socialMedialink': socialMedialink,
    };
  }

  factory SocialMediaModel.fromMap(Map<String, dynamic> map) {
    return SocialMediaModel(
      socialMediaId: map['socialMediaId'],
      userId: map['userId'],
      socialMediaPlatform: map['socialMediaPlatform'] ?? '',
      socialMedialink: map['socialMedialink'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialMediaModel.fromJson(String source) =>
      SocialMediaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SocialMediaModel(socialMediaId: $socialMediaId, userId: $userId, socialMediaPlatform: $socialMediaPlatform, socialMedialink: $socialMedialink)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SocialMediaModel &&
        other.socialMediaId == socialMediaId &&
        other.userId == userId &&
        other.socialMediaPlatform == socialMediaPlatform &&
        other.socialMedialink == socialMedialink;
  }

  @override
  int get hashCode {
    return socialMediaId.hashCode ^
        userId.hashCode ^
        socialMediaPlatform.hashCode ^
        socialMedialink.hashCode;
  }
}
