part of 'calendar_bloc.dart';

@immutable
sealed class CalendarState {}

final class CalendarInitial extends CalendarState {}

final class CalendarLoading extends CalendarState {}

final class CalendarLoaded extends CalendarState {
  final List<EventModel> events;

  CalendarLoaded({required this.events});
}

final class CalendarSuccess extends CalendarState {}

final class CalendarFailed extends CalendarState {}
