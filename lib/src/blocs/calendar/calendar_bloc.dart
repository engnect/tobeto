import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tobeto/src/domain/repositories/calendar_repository.dart';

import '../../models/calendar_model.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final CalendarRepository _calendarRepository;

  CalendarBloc(
    this._calendarRepository,
  ) : super(CalendarInitial()) {
    // eventları çekme
    on<FetchAllEvents>((event, emit) async {
      emit(CalendarLoading());
      try {
        final events = await _calendarRepository.fetchEventsFromFirestore();
        emit(CalendarLoaded(events: events));
      } catch (_) {
        emit(CalendarFailed());
      }
    });

    // event ekleme
    on<AddEvent>((event, emit) async {
      emit(CalendarLoading());
      try {
        await _calendarRepository.addOrUpdateEvent(
            eventModel: event.eventModel);
        emit(CalendarSuccess());
      } catch (_) {
        emit(CalendarFailed());
      }
    });

    // event güncelleme
    on<UpdateEvent>((event, emit) async {
      emit(CalendarLoading());
      try {
        await _calendarRepository.addOrUpdateEvent(
            eventModel: event.eventModel);
        emit(CalendarSuccess());
      } catch (_) {
        emit(CalendarFailed());
      }
    });

    // event silme
    on<UpdateEvent>((event, emit) async {
      emit(CalendarLoading());
      try {
        await _calendarRepository.deleteEvent(eventModel: event.eventModel);
        emit(CalendarSuccess());
      } catch (_) {
        emit(CalendarFailed());
      }
    });
  }
}
