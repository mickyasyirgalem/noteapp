import 'package:flutter/material.dart' show immutable;
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please Wait a Moment ...',
  });
}

class AuthStateUninitalized extends AuthState {
  const AuthStateUninitalized({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool hasSendEmail;

  const AuthStateForgotPassword({
    required this.exception,
    required this.hasSendEmail,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;

  const AuthStateRegistering({required this.exception, required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({required this.user, required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedInGoogle extends AuthState {
  const AuthStateLoggedInGoogle({required super.isLoading});
}

class AuthStateVerifyEmail extends AuthState {
  const AuthStateVerifyEmail({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(isLoading: isLoading, loadingText: loadingText);

  @override
  List<Object?> get props => [exception, isLoading];
}
