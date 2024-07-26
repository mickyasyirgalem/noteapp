import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_events.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/utilities/dialogs/password_reset.dart';

import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_state.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSendEmail) {
            _controller.clear();
            await passwordResetDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(context, 'We couldnt process your request..');
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Forgot Password')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                  'If you forgot your password enter your email in the bottom and we will send you a verification'),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _controller,
                decoration:
                    const InputDecoration(hintText: 'your email address'),
              ),
              TextButton(
                  onPressed: () {
                    final email = _controller.text;
                    context
                        .read<AuthBloc>()
                        .add(AuthEventForgotPassword(email: email));
                  },
                  child: const Text('Send me the reset link')),
              TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEventLogout());
                  },
                  child: const Text('Back to loginpage')),
            ],
          ),
        ),
      ),
    );
  }
}
