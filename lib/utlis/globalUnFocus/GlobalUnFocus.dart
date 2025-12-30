import 'package:flutter/cupertino.dart';

class GlobalUnFocus{
  static final focusNode = FocusNode();

  static void unFocus() {
    focusNode.unfocus();
  }

  static void dispose() {
    focusNode.dispose();
  }

}