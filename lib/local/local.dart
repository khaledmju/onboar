import 'package:get/get.dart';

class MyLocal implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "2": "تغير اللغة الى العربية",
          "3": "تغير اللغة الى الانكليزي",
        },
        "en": {
          "2": "change lang to arabic",
          "3": "change lang to english",
        },
      };
}
