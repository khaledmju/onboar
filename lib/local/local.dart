import 'package:get/get.dart';

class MyLocal implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "Setting":"الاعدادات",
          "Arabic":"عربي",
          "English":"انكليزي",
        },
        "en": {
          "Setting":"Setting",
          "Arabic":"Arabic",
          "English":"English",
        },
      };
}
