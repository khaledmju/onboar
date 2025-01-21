// ignore_for_file: equal_keys_in_map

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
          "Quantity":"الكمية",
          "Nova Cart" : "نوفا كارت",
          "Nova Dis":"تلتزم نوفا كارت بتقديم خدمات توصيل من الدرجة الأولى لعملائها على مدار الساعة وطوال أيام الأسبوع. نتحدى أنفسنا لتجاوز توقعات عملائنا باستمرار من خلال تقديم حلول مبتكرة لاحتياجاتهم.",
          "select item":"تتيح لك خدمتنا الجديدة التسوق في أي مكان بسهولة. اكتشف ميزات جديدة مثل البحث الأفضل والاختيارات المخصصة والخصومات الحصرية!",
          "add to cart":"يجعل التسوق سريعًا وبسيطًا. بنقرة واحدة فقط، يمكنك حفظ العناصر المفضلة لديك ومواصلة التصفح بسلاسة!",
          "fast delivery":"يضمن وصول طلباتك بسرعة وأمان. استمتع بخدمة موثوقة وسرعة يمكنك الوثوق بها! 🚀",
          "Skip":"تخطي",
          "Next":"التالي",
          "SELECT ITEMS":"اختيار المنتج",
          "ADD TO CART":"أضف الى سلتك",
          "FAST DELIVERY":"توصيل سريع وامن",
          "Get Started":"إبدأ",
          "Back":"السابق",
          "Sign Up":"أنشئ حساب جديد",
          "Log In":"تسجيل الدخول",
          "you dont have an account?":"ليس لديك حساب؟",
          "Already have an account?":"لديك حساب؟",
          "Password":"كلمة المرور",
          "Email Address":"البريد الإلكتروني",
          "Number":"الهاتف",
          "Phone Number":"رقم الهاتف",
          "Name":"الاسم",
          "User Name":"اسم المستخدم",
          "Last Name":"الاسم الأخير",
          "First Name":"الاسم الأول",
          "Please enter your Email Address":"أدخل البريد الإلكتروني",
          "Email is not valid":"البريد الإلأكتروني غير صالح",
          "Password must be at least 8 characters":"كلمة المرور يجب انت تكون على الأقل 8 أرقام",
          "Please fill the text fields correctly":"املئ الحقول بشكل صحيح",
          "Please enter your First Name":"أدخل الاسم الأول",
          "Please enter your Last Name":"أدخل الاسم الأخير",
          "First Name must be longer than 3 characters":"الاسم الأول يجب أن يكون أطول من 3 أحرف",
          "First Name must be shorter than 20 characters":"الاسم الأول يجب أن يكون أقصر من 20 حرف",
          "Last Name must be longer than 3 characters":"الاسم الأخير يجب أن يكون أطول 3 أحرف",
          "Last Name must be shorter than 20 characters":"الاسم الأخير يجب أن أقصر من 20 حرف",
          "Phone Number must be : 09XXXXXXXX":"09XXXXXXXX رقم الهاتف يجب أن يكون",
          "Phone Number must ONLY contain numbers":"يجب أن يكون فقط أرقام",
          "Phone Number must be 10 digits":"رقم الهاتف يجب أن يكون 10 أرقام",
          "Email is not valid":"البريد الإلكتروني غير صالح",
          "Please enter your password":"أدخل كلمة المرور",
          "Password must be at least 8 characters":"كلمة المرور يجب أن تكون على الأقل 8 أحرف",
          "Cart":"السلة",
          "Orders":"الطلبات",
          "Confirm":"تأكيد",
          "Confirm Purchase":"تأكيد الشراء",
          'Are you sure you want to confirm this purchase?':'هل انت متأكد أنك تريد إتمام عملية الشراء؟',
          "Your order has been sent. Awaiting confirmation from a driver.":"تم ارسال طلبك, انتظر موافقة السائق",
          "Total Price":"السعر الكلي ",
          "Total price":"السعر الكلي : ",
          "Favorite":"المفضلة",
          "Favorite Products":"المنتجات المفضلة",
          "No favorite products yet!":"لا يوجد منتجات مفضلة حاليا!",
          "Chose Image from:":"اختار الصورة من:",
          "Gallery":"المعرض",
          "Camera":"الكاميرا",
          "Profile":"الملف الشخصي",
          "Please enter your Phone Number":"ادخل رقم الهاتف الخاص بك",
          "Payment Method":"طرق الدفع",
          "Please enter your User Name":"ادخل اسم المستخدم",
          "User Name must be longer than 3 characters":"اسم المستخدم يجب أن يكون أطول من 3 أحرف",
          "User Name must be shorter than 20 characters":"اسم المستخدم يجب أن يكون أقصر من 20 حرف",
          "Validation Error":"خطأ",
          "Change Password":"تغير كلمة السر",
          "Old Password":"كلمة السر القديمة",
          "Confirm Password":"تاكيد كلمة السر",
          "New Password":"كلمة السر الجديدة",
          "Error":"خطأ",
          "Change User Name":"تغير اسم المستخدم",
          "Passwords do not match":"كلمة السر غير متطابقة",
          "Please confirm your password":"قم بتأكيد كلمة السر",
          "Please enter your User location":"ادخل الموقع الخاص بك",
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
          "Quantity":"Quantity",
          "Nova Cart" : "NOVA CART",
          "Nova Dis":"The Nova Cart is committed to providing first-class delivery services to its customers around the clock, seven days a week. We challenge ourselves to continuously exceed our customers' expectations by offering innovative solutions to their needs.",
          "select item":"Our new service lets you shop anywhere with ease. Discover new features like better search, personalized picks, and exclusive discounts!",
          "add to cart":"makes shopping quick and simple. With just one click, save your favorite items and continue browsing seamlessly!",
          "fast delivery":"ensures your orders arrive quickly and securely. Enjoy reliable service with speed you can trust! 🚀",
          "Skip":"Skip",
          "Next":"Next",
          "SELECT ITEMS":"SELECT ITEMS",
          "ADD TO CART":"ADD TO CART",
          "FAST DELIVERY":"FAST DELIVERY",
          "Get Started":"Get Started",
          "Back":"Back",
          "Log In":"Log In",
          "Sign Up":"Sign Up",
          "you dont have an account?":"you dont have an account?",
          "Already have an account?":"Already have an account?",
          "Password":"Password",
          "Email Address":"Email Address",
          "Number":"Number",
          "User Name":"User Name",
          "Last Name":"Last Name",
          "First Name":"First Name",
          "Please enter your Email Address":"Please enter your Email Address",
          "Email is not valid":"Email is not valid",
          "Please enter your password":"Please enter your password",
          "Password must be at least 8 characters":"Password must be at least 8 characters",
          "Please fill the text fields correctly": "Please fill the Text Fields correctly",
          "Please enter your First Name":"Please enter your First Name",
          "Please enter your Last Name":"Please enter your Last Name",
          "First Name must be longer than 3 characters":"First Name must be longer than 3 characters",
          "First Name must be shorter than 20 characters":"First Name must be shorter than 20 characters",
          "Last Name must be longer than 3 characters":"Last Name must be longer than 3 characters",
          "Last Name must be shorter than 20 characters":"Last Name must be shorter than 20 characters",
          "Phone Number must be : 09XXXXXXXX": "Phone Number must be : 09XXXXXXXX",
          "Phone Number must ONLY contain numbers":"Phone Number must ONLY contain numbers",
          "Phone Number must be 10 digits":"Phone Number must be 10 digits",
          "Email is not valid":"Email is not valid",
          "Password must be at least 8 characters":"Password must be at least 8 characters",
          "Cart":"Cart",
          "Orders":"Orders",
          "Confirm":"Confirm",
          "Confirm Purchase":"Confirm Purchase",
          'Are you sure you want to confirm this purchase?':'Are you sure you want to confirm this purchase?',
          "Your order has been sent. Awaiting confirmation from a driver.":"Your order has been sent. Awaiting confirmation from a driver.",
          "Total Price":"Total Price",
          "Total price":"Total Price :",
          "Favorite":"Favorite",
          "Favorite Products":"Favorite Products",
          "No favorite products yet!":"No favorite products yet!",
          "Chose Image from:":"Chose Image from:",
          "Gallery":"Gallery",
          "Camera":"Camera",
          "Profile":"Profile",
          "Please enter your Phone Number":"Please enter your Phone Number",
          "Payment Method":"Payment Method",
          "Phone Number":"Phone Number",
          "Please enter your User Name":"Please enter your User Name",
          "User Name must be longer than 3 characters":"User Name must be longer than 3 characters",
          "User Name must be shorter than 20 characters":"User Name must be shorter than 20 characters",
          "Validation Error":"Validation Error",
          "Name":"Name",
          "Change Password":"Change Password",
          "Old Password":"Old Password",
          "New Password":"New Password",
          "Confirm Password": "Confirm Password",
          "Error":"Error",
          "Change User Name":"Change User Name",
          "Passwords do not match":"Passwords do not match",
          "Please confirm your password":"Please confirm your password",
          "Please enter your User location":"Please enter your User location",
        },
      };
}
