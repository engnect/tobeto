import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(super.initialState) {
    on<ThemeChanged>((event, emit) {
      emit(ThemeState(themeData: event.themeData));
    });
  }
}
