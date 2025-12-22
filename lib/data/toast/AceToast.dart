import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class FlutterToast {

  // ----- restrict the toast only one toast show --------
  static bool isShowing = false;


  void flutterToast(
    String response,
    ToastificationType toastNotificationType,
    ToastificationStyle toastNotificationStyle,
  ) {

    if(isShowing) return;

    isShowing = true;

    toastification.show(
      description: RichText(
        text: TextSpan(
          text: response,
          style: TextStyle(
            color: toastNotificationType == ToastificationType.success
                ? Colors.green
                : Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
      autoCloseDuration: const Duration(seconds: 3),
      type: toastNotificationType,
      style: toastNotificationStyle,
      showProgressBar: true,
      borderSide: BorderSide(
        color: toastNotificationType == ToastificationType.success
            ? Colors.green
            : Colors.red,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(16),
      dragToClose: false,
      closeOnClick: true
    );

    // ------- after showing completed then reset the toast ----------
    Timer(Duration(seconds: 3),(){
      isShowing = false;
    });
  }
}
