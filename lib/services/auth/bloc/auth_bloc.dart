import 'package:bloc/bloc.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/bloc/auth_events.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUninitalized(isLoading: true)) {
    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });
    on<AuthEventRegister>((event, emit) async {
      final email = event.email;
      final password = event.password;
      try {
        await provider.createUser(
          email: email,
          password: password,
        );
        await provider.sendEmailVerification();
        emit(const AuthStateVerifyEmail(isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateRegistering(exception: e, isLoading: false));
      }
    });
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: false,
        ));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateVerifyEmail(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(
          user: user,
          isLoading: false,
        ));
      }
    });
    on<AuthEventShouldRegister>((event, emit) async {
      emit(const AuthStateLoggedOut(
        exception: null,
        isLoading: true,
      ));
      try {
        emit(
          const AuthStateLoggedOut(exception: null, isLoading: false),
        );
        emit(const AuthStateRegistering(exception: null, isLoading: false));
      } on Exception catch (e) {
        AuthStateRegistering(exception: e, isLoading: false);
      }
    });
    on<AuthEventForgotPassword>((event, emit) async {
      emit(const AuthStateForgotPassword(
        exception: null,
        hasSendEmail: false,
        isLoading: false,
      ));
      final email = event.email;
      if (email == null) {
        return;
      }
      emit(const AuthStateForgotPassword(
        exception: null,
        hasSendEmail: false,
        isLoading: true,
      ));
      bool didSendEmail;
      Exception? exception;
      try {
        await provider.sendPasswordReset(email: email);
        didSendEmail = true;
        exception = null;
      } on Exception catch (e) {
        didSendEmail = false;
        exception = e;
      }
      emit(AuthStateForgotPassword(
        exception: exception,
        hasSendEmail: didSendEmail,
        isLoading: false,
      ));
    });
    on<AuthEventGoogleLogin>((event, emit) async {
      emit(const AuthStateLoggedOut(
        exception: null,
        isLoading: true,
        loadingText: 'please wait while i log you in',
      ));
      try {
        emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: false,
        ));
        emit(const AuthStateLoggedInGoogle(isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(
          exception: e,
          isLoading: false,
        ));
      }
    });
    on<AuthEventLogin>((event, emit) async {
      emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: true,
          loadingText: 'Please wait while I log you in'));
      final email = event.email;
      final password = event.password;
      try {
        final user = await provider.logIn(
          email: email,
          password: password,
        );
        if (!user.isEmailVerified) {
          emit(const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ));
          emit(const AuthStateVerifyEmail(isLoading: false));
        } else {
          emit(const AuthStateLoggedOut(
            exception: null,
            isLoading: false,
          ));
          emit(AuthStateLoggedIn(
            user: user,
            isLoading: false,
          ));
        }
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(
          exception: e,
          isLoading: false,
        ));
      }
    });
    on<AuthEventLogout>((event, emit) async {
      try {
        await provider.logOut();
        emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(exception: e, isLoading: false));
      }
    });
  }
}
