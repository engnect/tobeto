part of 'calendar_bloc.dart';

@immutable
sealed class CalendarEvent {}

final class FetchAllEvents extends CalendarEvent {}

final class AddEvent extends CalendarEvent {
  final EventModel eventModel;

  AddEvent({required this.eventModel});
}

final class UpdateEvent extends CalendarEvent {
  final EventModel eventModel;

  UpdateEvent({required this.eventModel});
}

final class DeleteEvent extends CalendarEvent {
  final EventModel eventModel;

  DeleteEvent({required this.eventModel});
}
