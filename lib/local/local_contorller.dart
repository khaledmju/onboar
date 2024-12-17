import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onboar/main.dart';

class MyLocaleController extends GetxController {
  Locale initlang = prefs!.get("lang") == null
      ? Get.deviceLocale!
      : Locale(prefs!.getString("lang")!);

  changeLang(String langCode) {
    Locale localLang = Locale(langCode);
    prefs!.setString("lang", langCode);
    Get.updateLocale(localLang);
    update();
  }
}
