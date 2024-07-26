import 'package:flutter/foundation.dart';

typedef CloseLoading = bool Function();
typedef UpdateLoading = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoading close;
  final UpdateLoading update;

  const LoadingScreenController({
    required this.close,
    required this.update,
  });
}
