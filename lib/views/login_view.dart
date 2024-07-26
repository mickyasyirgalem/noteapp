import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/bloc/auth_events.dart';
import '../components/my_button.dart';
import '../components/my_text_field.dart';
import '../components/square_tile.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_state.dart';
import '../utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthStateLoggedOut) {
            if (state.exception is UserNotFoundAuthException) {
              await showErrorDialog(context, 'User Not Found');
            } else if (state.exception is WrongPasswordAuthException) {
              await showErrorDialog(context, 'Wrong Credentials');
            } else if (state.exception is GenericAuthException) {
              await showErrorDialog(context, 'Authentication Error');
            }
          }
        },
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: SafeArea(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Icon(
                  Icons.house_sharp,
                  size: 100,
                ),
                const SizedBox(height: 50),
                const Text(
                  'Welcome Back You\'ve been missed',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: _email,
                  hint: 'Email Address',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                    controller: _password, hint: 'Password', obscureText: true),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () async {
                    context.read<AuthBloc>().add(
                          const AuthEventForgotPassword(),
                        );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Mybutton(
                  typeOfButton: 'Login',
                  onTap: () async {
                    final email = _email.text;
                    final password = _password.text;
                    context.read<AuthBloc>().add(AuthEventLogin(
                          email,
                          password,
                        ));
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      imagePath: 'lib/image/google.png',
                      onTap: () async {
                        context
                            .read<AuthBloc>()
                            .add(const AuthEventGoogleLogin());
                      },
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    SquareTile(
                      imagePath: 'lib/image/face2.jpg',
                      onTap: () {},
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    TextButton(
                      onPressed: () async {
                        context.read<AuthBloc>().add(
                              const AuthEventShouldRegister(),
                            );
                      },
                      child: const Text('Register now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                )
              ],
            ),
          )),
        ));
  }
}    
  
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
//       Scaffold(
//         appBar: AppBar(
//           title: const Text('Login'),
//         ),
//         body: Column(
//           children: [
//             TextField(
//               controller: _email,
//               enableSuggestions: false,
//               autocorrect: false,
//               keyboardType: TextInputType.emailAddress,
//               decoration: const InputDecoration(
//                 hintText: 'Enter your email here',
//               ),
//             ),
//             TextField(
//               controller: _password,
//               obscureText: true,
//               enableSuggestions: false,
//               autocorrect: false,
//               decoration: const InputDecoration(
//                 hintText: 'Enter your password here',
//               ),
//             ),
//             TextButton(
//               onPressed: () async {
//                 final email = _email.text;
//                 final password = _password.text;
//                 context.read<AuthBloc>().add(AuthEventLogin(
//                       email,
//                       password,
//                     ));
//               },
//               child: const Text('Login'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 context.read<AuthBloc>().add(
//                       const AuthEventForgotPassword(),
//                     );
//               },
//               child: const Text('Forgot Password'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 context.read<AuthBloc>().add(
//                       const AuthEventShouldRegister(),
//                     );
//               },
//               child: const Text('Not registered yet? Register here!'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
