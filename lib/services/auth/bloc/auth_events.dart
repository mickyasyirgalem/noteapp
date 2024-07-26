import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

class AuthEventSendEmailVerification extends AuthEvent {
  const AuthEventSendEmailVerification();
}

class AuthEventRegister extends AuthEvent {
  final String email;
  final String password;

  const AuthEventRegister(this.email, this.password);
}

class AuthEventShouldRegister extends AuthEvent {
  const AuthEventShouldRegister();
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventForgotPassword extends AuthEvent {
  final String? email;

  const AuthEventForgotPassword({this.email});
}

class AuthEventGoogleLogin extends AuthEvent {
  const AuthEventGoogleLogin();
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthEventLogin(this.email, this.password);
}

class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();
}
