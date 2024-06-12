part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

class _UserAuthenticated extends AuthEvent {
  final UserModel userModel;

  _UserAuthenticated({required this.userModel});
}

class _UserUnauthenticated extends AuthEvent {}
