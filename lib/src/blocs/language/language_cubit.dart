import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  int languageValue;

  LanguageCubit({this.languageValue = 1}) : super(const Locale('tr', 'TR'));

  void changeLanguage(Locale locale, int newValue) {
    languageValue = newValue;
    emit(locale);
  }
}
