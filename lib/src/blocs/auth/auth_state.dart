part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserModel userModel;

  Authenticated({required this.userModel});
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}
