import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/domain/repositories/user_repository.dart';
import 'package:tobeto/src/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth firebaseAuth;
  final UserRepository userRepository;

  StreamSubscription<UserModel?>? _userStreamSubscription;

  AuthBloc({
    required this.firebaseAuth,
    required this.userRepository,
  }) : super(AuthInitial()) {
    firebaseAuth.authStateChanges().listen((User? firebaseUser) async {
      await _userStreamSubscription?.cancel();
      if (firebaseUser != null) {
        _userStreamSubscription = userRepository.getUserStream().listen(
          (customUser) {
            if (customUser != null) {
              add(_UserAuthenticated(userModel: customUser));
            } else {
              add(_UserUnauthenticated());
            }
          },
        );
      } else {
        add(_UserUnauthenticated());
      }
    });

    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<SignInRequested>(_onSignInRequested);
    on<_UserAuthenticated>(_onUserAuthenticated);
    on<_UserUnauthenticated>(_onUserUnauthenticated);
  }

  Future<void> _onAuthCheckRequested(
      AuthCheckRequested event, Emitter<AuthState> emit) async {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      final customUser = await userRepository.getCurrentUser();
      if (customUser != null) {
        emit(Authenticated(userModel: customUser));
      } else {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event, Emitter<AuthState> emit) async {
    await firebaseAuth.signOut();
    emit(Unauthenticated());
  }

  Future<void> _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      await firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
    } catch (e) {
      emit(AuthError(error: e.toString()));
    }
  }

  void _onUserAuthenticated(_UserAuthenticated event, Emitter<AuthState> emit) {
    emit(Authenticated(userModel: event.userModel));
  }

  void _onUserUnauthenticated(
      _UserUnauthenticated event, Emitter<AuthState> emit) {
    emit(Unauthenticated());
  }

  @override
  Future<void> close() {
    _userStreamSubscription?.cancel();
    return super.close();
  }
}
