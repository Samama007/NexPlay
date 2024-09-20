import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nexplay/util/theme.dart';

void toast(String message, BuildContext context) {
  Color backgroundColor = Theme.of(context).colorScheme.primary;
  // Color foregroundColor = Theme.of(context).colorScheme.secondary;
  // Color tertiaryColor = Theme.of(context).colorScheme.tertiary;
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: backgroundColor,
    textColor: foregroundColor,
    gravity: ToastGravity.BOTTOM,
    fontSize: 18,
    toastLength: Toast.LENGTH_LONG,
  );
}
