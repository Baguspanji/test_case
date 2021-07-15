import 'dart:ffi';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

on_failed(context, String message) {
  Alert(
    context: context,
    type: AlertType.error,
    title: message,
    buttons: [
      DialogButton(
        color: Colors.red,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

on_info(context, String message) {
  Alert(
    context: context,
    type: AlertType.info,
    title: message,
    buttons: [
      DialogButton(
        color: Colors.blue,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}

on_success(context, String message, void func) {
  Alert(
    context: context,
    type: AlertType.success,
    title: message,
    buttons: [
      DialogButton(
        color: Colors.greenAccent,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          func;
          Navigator.pop(context);
        },
        width: 120,
      )
    ],
  ).show();
}

on_warning(context, String message, void func) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: message,
    buttons: [
      DialogButton(
        color: Colors.orangeAccent,
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          func;
          Navigator.pop(context);
        },
        width: 120,
      )
    ],
  ).show();
}
