
import 'package:flutter/material.dart';

class Validators {
  String? validEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validPhoneWhatsapp(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone(whatsapp)";
    }
    if (!RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validPhoneAlternate(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone(alternate)";
    }
    if (!RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password";
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validFirstname (String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your first name";
    }
    return null;
  }

  String? validLastname (String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your last name";
    }
    return null;
  }

  String? validName (String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name";
    }
    return null;
  }
  String? validDomainMail (String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your domain mail id";
    }
    return null;
  }

  String? validPhone (String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone number";
    }
    return null;
  }

  String? validPinPut (String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your verified OTP";
    }
    return null;
  }
}

class ImageLoader {
  Widget build(BuildContext context, Widget? child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      return child ?? const SizedBox();
    } else {
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
              : null,
        ),
      );
    }
  }
}

// class FlutterToast {
//   flutterToast(String response, ToastificationType toastNotificationType, ToastificationStyle toastNotificationStyle) {
//     toastification.show(
//         description: RichText(text: TextSpan(text: response,style: TextStyle(color: toastNotificationType == ToastificationType.success ? Colors.green : Colors.red,fontSize: 14,fontWeight: FontWeight.bold,fontFamily: "Roboto"))),
//         autoCloseDuration: const Duration(seconds: 5),
//         type: toastNotificationType,
//         style: toastNotificationStyle,
//         showProgressBar: true,
//         borderSide: BorderSide(color:toastNotificationType == ToastificationType.success ? Colors.green : Colors.red, width: 0.5),
//         borderRadius: BorderRadius.circular(16)
//     );
//   }
// }