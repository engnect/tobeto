import 'dart:convert';

class AnnouncementModel {
  final String announcementId;
  final String userId;
  final String announcementTitle;
  final String announcementContent;
  final DateTime announcementDate;
  AnnouncementModel({
    required this.announcementId,
    required this.userId,
    required this.announcementTitle,
    required this.announcementContent,
    required this.announcementDate,
  });

  AnnouncementModel copyWith({
    String? announcementId,
    String? userId,
    String? announcementTitle,
    String? announcementContent,
    DateTime? announcementDate,
  }) {
    return AnnouncementModel(
      announcementId: announcementId ?? this.announcementId,
      userId: userId ?? this.userId,
      announcementTitle: announcementTitle ?? this.announcementTitle,
      announcementContent: announcementContent ?? this.announcementContent,
      announcementDate: announcementDate ?? this.announcementDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'announcementId': announcementId,
      'userId': userId,
      'announcementTitle': announcementTitle,
      'announcementContent': announcementContent,
      'announcementDate': announcementDate,
    };
  }

  factory AnnouncementModel.fromMap(Map<String, dynamic> map) {
    return AnnouncementModel(
      announcementId: map['announcementId'] ?? '',
      userId: map['userId'] ?? '',
      announcementTitle: map['announcementTitle'] ?? '',
      announcementContent: map['announcementContent'] ?? '',
      announcementDate: map['announcementDate'].toDate() ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AnnouncementModel.fromJson(String source) =>
      AnnouncementModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AnnouncementModel(announcementId: $announcementId, userId: $userId, announcementTitle: $announcementTitle, announcementContent: $announcementContent, announcementDate: $announcementDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnnouncementModel &&
        other.announcementId == announcementId &&
        other.userId == userId &&
        other.announcementTitle == announcementTitle &&
        other.announcementContent == announcementContent &&
        other.announcementDate == announcementDate;
  }

  @override
  int get hashCode {
    return announcementId.hashCode ^
        userId.hashCode ^
        announcementTitle.hashCode ^
        announcementContent.hashCode ^
        announcementDate.hashCode;
  }
}
