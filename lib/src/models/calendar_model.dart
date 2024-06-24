import 'dart:convert';

class CalendarModel {
  final String eventId;
  final String userId;
  final String userNameAndSurname;
  final String eventTitle;
  final String eventDescription;
  final DateTime eventDate;
  CalendarModel({
    required this.eventId,
    required this.userId,
    required this.userNameAndSurname,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
  });

  CalendarModel copyWith({
    String? eventId,
    String? userId,
    String? userNameAndSurname,
    String? eventTitle,
    String? eventDescription,
    DateTime? eventDate,
  }) {
    return CalendarModel(
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      userNameAndSurname: userNameAndSurname ?? this.userNameAndSurname,
      eventTitle: eventTitle ?? this.eventTitle,
      eventDescription: eventDescription ?? this.eventDescription,
      eventDate: eventDate ?? this.eventDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'userId': userId,
      'userNameAndSurname': userNameAndSurname,
      'eventTitle': eventTitle,
      'eventDescription': eventDescription,
      'eventDate': eventDate,
    };
  }

  factory CalendarModel.fromMap(Map<String, dynamic> map) {
    return CalendarModel(
      eventId: map['eventId'] ?? '',
      userId: map['userId'] ?? '',
      userNameAndSurname: map['userNameAndSurname'] ?? '',
      eventTitle: map['eventTitle'] ?? '',
      eventDescription: map['eventDescription'] ?? '',
      eventDate: map['eventDate'].toDate() ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarModel.fromJson(String source) =>
      CalendarModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CalendarModel(eventId: $eventId, userId: $userId, userNameAndSurname: $userNameAndSurname, eventTitle: $eventTitle, eventDescription: $eventDescription, eventDate: $eventDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CalendarModel &&
        other.eventId == eventId &&
        other.userId == userId &&
        other.userNameAndSurname == userNameAndSurname &&
        other.eventTitle == eventTitle &&
        other.eventDescription == eventDescription &&
        other.eventDate == eventDate;
  }

  @override
  int get hashCode {
    return eventId.hashCode ^
        userId.hashCode ^
        userNameAndSurname.hashCode ^
        eventTitle.hashCode ^
        eventDescription.hashCode ^
        eventDate.hashCode;
  }
}
