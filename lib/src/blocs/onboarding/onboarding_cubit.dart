import 'package:hydrated_bloc/hydrated_bloc.dart';

class OnboardingCubit extends HydratedCubit<bool> {
  OnboardingCubit() : super(false);

  void completeOnboarding() => emit(true);

  @override
  bool fromJson(Map<String, dynamic> json) => json['completed'] as bool;

  @override
  Map<String, dynamic> toJson(bool state) => {'completed': state};
}
