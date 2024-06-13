import 'dart:convert';

class ContactFormModel {
  final String contactFormId;
  final String contactFormFullName;
  final String contactFormEmail;
  final String contactFormMessage;
  final DateTime contactFormCreatedAt;
  final bool contactFormIsClosed;
  final String contactFormClosedBy;
  final DateTime contactFormClosedAt;
  ContactFormModel({
    required this.contactFormId,
    required this.contactFormFullName,
    required this.contactFormEmail,
    required this.contactFormMessage,
    required this.contactFormCreatedAt,
    required this.contactFormIsClosed,
    required this.contactFormClosedBy,
    required this.contactFormClosedAt,
  });

  ContactFormModel copyWith({
    String? contactFormId,
    String? contactFormFullName,
    String? contactFormEmail,
    String? contactFormMessage,
    DateTime? contactFormCreatedAt,
    bool? contactFormIsClosed,
    String? contactFormClosedBy,
    DateTime? contactFormClosedAt,
  }) {
    return ContactFormModel(
      contactFormId: contactFormId ?? this.contactFormId,
      contactFormFullName: contactFormFullName ?? this.contactFormFullName,
      contactFormEmail: contactFormEmail ?? this.contactFormEmail,
      contactFormMessage: contactFormMessage ?? this.contactFormMessage,
      contactFormCreatedAt: contactFormCreatedAt ?? this.contactFormCreatedAt,
      contactFormIsClosed: contactFormIsClosed ?? this.contactFormIsClosed,
      contactFormClosedBy: contactFormClosedBy ?? this.contactFormClosedBy,
      contactFormClosedAt: contactFormClosedAt ?? this.contactFormClosedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'contactFormId': contactFormId,
      'contactFormFullName': contactFormFullName,
      'contactFormEmail': contactFormEmail,
      'contactFormMessage': contactFormMessage,
      'contactFormCreatedAt': contactFormCreatedAt,
      'contactFormIsClosed': contactFormIsClosed,
      'contactFormClosedBy': contactFormClosedBy,
      'contactFormClosedAt': contactFormClosedAt,
    };
  }

  factory ContactFormModel.fromMap(Map<String, dynamic> map) {
    return ContactFormModel(
      contactFormId: map['contactFormId'] ?? '',
      contactFormFullName: map['contactFormFullName'] ?? '',
      contactFormEmail: map['contactFormEmail'] ?? '',
      contactFormMessage: map['contactFormMessage'] ?? '',
      contactFormCreatedAt:
          map['contactFormCreatedAt'].toDate() ?? DateTime.now(),
      contactFormIsClosed: map['contactFormIsClosed'] ?? false,
      contactFormClosedBy: map['contactFormClosedBy'] ?? '',
      contactFormClosedAt:
          map['contactFormClosedAt'].toDate() ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactFormModel.fromJson(String source) =>
      ContactFormModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ContactFormModel(contactFormId: $contactFormId, contactFormFullName: $contactFormFullName, contactFormEmail: $contactFormEmail, contactFormMessage: $contactFormMessage, contactFormCreatedAt: $contactFormCreatedAt, contactFormIsClosed: $contactFormIsClosed, contactFormClosedBy: $contactFormClosedBy, contactFormClosedAt: $contactFormClosedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ContactFormModel &&
        other.contactFormId == contactFormId &&
        other.contactFormFullName == contactFormFullName &&
        other.contactFormEmail == contactFormEmail &&
        other.contactFormMessage == contactFormMessage &&
        other.contactFormCreatedAt == contactFormCreatedAt &&
        other.contactFormIsClosed == contactFormIsClosed &&
        other.contactFormClosedBy == contactFormClosedBy &&
        other.contactFormClosedAt == contactFormClosedAt;
  }

  @override
  int get hashCode {
    return contactFormId.hashCode ^
        contactFormFullName.hashCode ^
        contactFormEmail.hashCode ^
        contactFormMessage.hashCode ^
        contactFormCreatedAt.hashCode ^
        contactFormIsClosed.hashCode ^
        contactFormClosedBy.hashCode ^
        contactFormClosedAt.hashCode;
  }
}
