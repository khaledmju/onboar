import 'package:get/get.dart';

class MyLocal implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "Setting":"الإعدادات",
          "Arabic":"عربي",
          "English":"انكليزي",
          "Log Out":"تسجيل الخروج",
          "About Us":"من نحن",
          "Contact Us":"تواصل معنا",
          "App Language":"لغة التطبيق",
          "Home":" الرئيسية",
          "No favorite stores yet!":"لا يوجد متاجر مفضلة حاليا",
          "Favorite Stores":"المتاجر المفضلة",
          "Search for Stores..":"البحث عن متجر..",
          'Are you sure you want to log out?':'هل أنت متأكد من تسجيل خروجك ؟',
          "Cancel" : "لا",
          "Ok":"نعم",
          "Products":"المنتجات",
          "Add to Cart" : "إضافة الى السلة",
          "Price":"السعر",
        },
        "en": {
          "Setting":"Setting",
          "Arabic":"Arabic",
          "English":"English",
          "Log Out":"Log Out",
          "About Us":"About Us",
          "Contact Us":"Contact Us",
          "App Language":"App Language",
          "Home":"Home",
          "No favorite stores yet!":"No favorite stores yet!",
          "Favorite Stores":"Favorite Stores",
          "Search for Stores..":"Search for Stores..",
          'Are you sure you want to log out?':'Are you sure you want to log out ?',
          "Cancel" : "Cancel",
          "Ok":"Ok",
          "Products":"Products",
          "Add to Cart": "Add to Cart",
          "Price":"Price",
        },
      };
}
