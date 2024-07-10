import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<bool> {
  ThemeCubit() : super(false);

  void toggleTheme() => emit(!state);

  @override
  bool fromJson(Map<String, dynamic> json) => json['isDarkMode'] as bool;

  @override
  Map<String, dynamic> toJson(bool state) => {'isDarkMode': state};
}
