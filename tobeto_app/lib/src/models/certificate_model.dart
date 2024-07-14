import 'dart:convert';

class CertificateModel {
  final String certificateId;
  final String userId;
  final String certificateName;
  final DateTime certificateYear;
  String certificateFileUrl;
  CertificateModel({
    required this.certificateId,
    required this.userId,
    required this.certificateName,
    required this.certificateYear,
    required this.certificateFileUrl,
  });

  CertificateModel copyWith({
    String? certificateId,
    String? userId,
    String? certificateName,
    DateTime? certificateYear,
    String? certificateFileUrl,
  }) {
    return CertificateModel(
      certificateId: certificateId ?? this.certificateId,
      userId: userId ?? this.userId,
      certificateName: certificateName ?? this.certificateName,
      certificateYear: certificateYear ?? this.certificateYear,
      certificateFileUrl: certificateFileUrl ?? this.certificateFileUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'certificateId': certificateId,
      'userId': userId,
      'certificateName': certificateName,
      'certificateYear': certificateYear,
      'certificateFileUrl': certificateFileUrl,
    };
  }

  factory CertificateModel.fromMap(Map<String, dynamic> map) {
    return CertificateModel(
      certificateId: map['certificateId'] ?? '',
      userId: map['userId'] ?? '',
      certificateName: map['certificateName'] ?? '',
      certificateYear: map['certificateYear'].toDate() ?? '',
      certificateFileUrl: map['certificateFileUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CertificateModel.fromJson(String source) =>
      CertificateModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CertificateModel(certificateId: $certificateId, userId: $userId, certificateName: $certificateName, certificateYear: $certificateYear, certificateFileUrl: $certificateFileUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CertificateModel &&
        other.certificateId == certificateId &&
        other.userId == userId &&
        other.certificateName == certificateName &&
        other.certificateYear == certificateYear &&
        other.certificateFileUrl == certificateFileUrl;
  }

  @override
  int get hashCode {
    return certificateId.hashCode ^
        userId.hashCode ^
        certificateName.hashCode ^
        certificateYear.hashCode ^
        certificateFileUrl.hashCode;
  }
}
