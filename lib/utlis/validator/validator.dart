import 'package:flutter/material.dart';

class Validators {
  String? validEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your email";
    }
    if (!RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validPhoneWhatsapp(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone(whatsapp)";
    }
    if (!RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validPhoneAlternate(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone(alternate)";
    }
    if (!RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(value)) {
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

  String? validFirstname(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your first name";
    }
    return null;
  }

  String? validLastname(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your last name";
    }
    return null;
  }

  String? validPayment(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your payment";
    }
    return null;
  }

  String? validName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name";
    }
    return null;
  }

  String? validTicketName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your ticker name";
    }
    return null;
  }

  String? validAmount(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your amount";
    }
    return null;
  }

  String? validDescription(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your description";
    }
    return null;
  }

  String? validTitle(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter title";
    }
    return null;
  }

  String? validDomainMail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your domain mail id";
    }
    return null;
  }

  String? validPhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your phone number";
    }
    return null;
  }

  String? validAbout(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your about the event";
    }
    return null;
  }

  String? validContactAdmin(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your describe your request";
    }
    return null;
  }
  String? validGoogleMeet(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your google meet link";
    }
    return null;
  }

  String? validVenue(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your venue";
    }
    return null;
  }

  String? validPinPut(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your verified OTP";
    }
    return null;
  }

  String? validCountry(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your country";
    }
    return null;
  }

  String? validEventMode(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your event mode";
    }
    return null;
  }

  String? validState(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your country";
    }
    return null;
  }

  String? validCity(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your country";
    }
    return null;
  }

  String? validOrgCategories(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your organization category";
    }
    return null;
  }

  String? validPerks(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your perks";
    }
    return null;
  }

  String? validCertification(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your certification";
    }
    return null;
  }

  String? validTypeOfEvents(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your type of events";
    }
    return null;
  }

  String? validTotalCount(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your total count";
    }
    return null;
  }

  String? validAccommodation(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your accommodation";
    }
    return null;
  }

  String? validOrgDepartment(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your organization department";
    }
    return null;
  }

  String? validTimeZone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your time zone";
    }
    return null;
  }

  String? validEligibleDepartment(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your eligible department";
    }
    return null;
  }

  String? validOrganizationName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your organization name";
    }
    return null;
  }

  String? validComment(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your thoughts";
    }
    return null;
  }

  String? validOrganizationPhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your organization name";
    }
    return null;
  }

  String? validLocation(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select your location";
    }
    return null;
  }
}

class ImageLoader {
  Widget build(
    BuildContext context,
    Widget? child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) {
      return child ?? const SizedBox();
    } else {
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
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
