import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    gravity: ToastGravity.BOTTOM,
    fontSize: 18,
    toastLength: Toast.LENGTH_LONG,
  );
}
