import 'package:flutter/services.dart';

class GmailLauncher {
  static const MethodChannel _channel = MethodChannel('open_gmail');

  static Future<void> openGmail() async {
    try {
      print("dfhsdkjfhsdkjhfkdsjhgsldgsdjhgsjhgjksdfhgjdfhgjkdfgkjdfgh");
      await _channel.invokeMethod('openGmail');
    } catch (e) {
      print('Gmailnotinstalledorfailedtoopen$e');
    }
  }
}
