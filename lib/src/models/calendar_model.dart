import 'dart:convert';

class EventModel {
  final String eventId;
  final String userId;
  final String eventTitle;
  final String eventDescription;
  final DateTime eventDate;
  EventModel({
    required this.eventId,
    required this.userId,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
  });

  EventModel copyWith({
    String? eventId,
    String? userId,
    String? eventTitle,
    String? eventDescription,
    DateTime? eventDate,
  }) {
    return EventModel(
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      eventTitle: eventTitle ?? this.eventTitle,
      eventDescription: eventDescription ?? this.eventDescription,
      eventDate: eventDate ?? this.eventDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'userId': userId,
      'eventTitle': eventTitle,
      'eventDescription': eventDescription,
      'eventDate': eventDate,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      eventId: map['eventId'] ?? '',
      userId: map['userId'] ?? '',
      eventTitle: map['eventTitle'] ?? '',
      eventDescription: map['eventDescription'] ?? '',
      eventDate: map['eventDate'].toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EventModel.fromJson(String source) =>
      EventModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EventModel(eventId: $eventId, userId: $userId, eventTitle: $eventTitle, eventDescription: $eventDescription, eventDate: $eventDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventModel &&
        other.eventId == eventId &&
        other.userId == userId &&
        other.eventTitle == eventTitle &&
        other.eventDescription == eventDescription &&
        other.eventDate == eventDate;
  }

  @override
  int get hashCode {
    return eventId.hashCode ^
        userId.hashCode ^
        eventTitle.hashCode ^
        eventDescription.hashCode ^
        eventDate.hashCode;
  }
}
