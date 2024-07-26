import 'package:flutter/widgets.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> passwordResetDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content: 'We have sent you a password reset verificaton.',
    optionBuilder: () => {'Ok': null},
  );
}
