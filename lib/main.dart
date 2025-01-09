// ignore_for_file: unused_import, use_key_in_widget_constructors, avoid_unnecessary_containers, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddImageProfile.dart';
import 'Driver.dart';
import 'FavoritesController.dart';
import 'LogIn.dart';
import 'Stores.dart';
import 'local/local.dart';
import 'local/local_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;
String? baseurl = "http://127.0.0.1:8000" ;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  final showHome = prefs?.getBool('showHome') ?? false;
  final isDriver = prefs?.getBool('isDriver') ?? false;
  runApp(MyApp(showHome: showHome,isDriver:isDriver));
  Get.put(FavoritesController());
}

class MyApp extends StatelessWidget {
  final bool showHome;
  final bool isDriver;

  const MyApp({super.key, required this.showHome,required this.isDriver});

  @override
  Widget build(BuildContext context) {
    MyLocaleController localeController = Get.put(MyLocaleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NovaCart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: showHome
          ? (isDriver ? Driver() : const Stores())
          : OnboardingPage(),
      locale: localeController.initlang,
      translations: MyLocal(),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  bool isLastPage = false;
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget buildPage({
    required String urlImage,
    required String title,
    required String discr,
  }) =>
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    pageController.animateToPage(2, duration: const Duration(milliseconds: 1500), curve: Curves.easeInOut);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 5,left: 5),
                    alignment: Alignment.center,
                    width: 90,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 20, 54, 64),
                        borderRadius: BorderRadius.circular(40)),
                    height: 65,
                    child:Text("Skip".tr,style:  const TextStyle(
                        fontSize: 19,
                        color: Color.fromARGB(255, 66, 252, 169),)),
                  ),
                )],
            ),
            Image.asset(
              urlImage,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 20, 54, 64),
                boxShadow: const [BoxShadow(color: Colors.green, blurRadius: 10)],
              ),
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 20, 54, 64),
                boxShadow: const [BoxShadow(color: Colors.green, blurRadius: 12)],
              ),
              padding: const EdgeInsets.all(20),
              child: Text(
                discr,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 66, 252, 169),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (value) {
            setState(() {
              isLastPage = value == 2;
            });
          },
          controller: pageController,
          children: [
            buildPage(
                urlImage: "images/9.png",
                title: "SELECT ITEMS".tr,
                discr: "select item".tr),
            buildPage(
                urlImage: "images/7.png",
                title: "ADD TO CART".tr,
                discr: "add to cart".tr),
            buildPage(
                urlImage: "images/1.png",
                title: "FAST DELIVERY".tr,
                discr:"fast delivery".tr),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              width: double.infinity,
              // margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 20, 54, 64),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: 65,
              child: TextButton(
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LogIn(),
                    ));
                  },
                  child: Text(
                    "Get Started".tr,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 66, 252, 169),
                    ),
                  )),
            )
          : Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 20, 54, 64),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      // onPressed: () => pageController.animateToPage(2, duration: Duration(milliseconds: 1500), curve: Curves.easeInOut),
                      onPressed: () => pageController.previousPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: Text(
                        "Back".tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Color.fromARGB(255, 66, 252, 169),
                        ),
                      )),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut),
                    effect: const WormEffect(
                      spacing: 15,
                      activeDotColor: Color.fromARGB(255, 66, 252, 169),
                    ),
                  ),
                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: Text("Next".tr,
                          style: const TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 66, 252, 169),
                          ))),
                ],
              ),
            ),
    );
  }
}
