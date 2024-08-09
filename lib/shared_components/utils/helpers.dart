import 'package:flutter/material.dart';

import 'constants.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  Color backgroundColor = primaryColors,
  Duration duration = const Duration(seconds: 2),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Text(message),
      duration: duration,
    ),
  );
}
