import 'package:all_college_event_app/features/auth/organizer/signUp/model/VerifyModel.dart';
import 'package:all_college_event_app/main.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

class DeepLinkService {
  static final appLink = AppLinks();

  // ------- app open state then working the deep link --------
  void initial() async {
    final uri = await appLink.getInitialLink();
    if (uri != null) {
      handleDeepLink(uri);
    }
  }

  // ----- handle the deeplink enter the page ----------
  void handleDeepLink(Uri uri) async {
    print("deeplinkdeeplinkdeeplinkdeeplinkdeeplinkdeeplink");
    if (uri.scheme == 'myapp' && uri.host == 'verified') {
      final token = uri.queryParameters['token'];
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => VerifyModel(
            mailId: token ?? '',
          ),
        ),
      );
    }
  }
}
