import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboar/AddImageProfile.dart';
import 'package:onboar/Home.dart';
import 'package:onboar/Stores.dart';
import 'package:onboar/local/local.dart';
import 'package:onboar/local/local_contorller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? prefs;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  final showHome = prefs?.getBool('showHome') ?? false;
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;

  const MyApp({super.key, required this.showHome});

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
      home: showHome ? Stores() : OnboardingPage(),
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
            SizedBox(
              height: 60,
            ),
            Image.asset(
              urlImage,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 20, 54, 64),
                boxShadow: [BoxShadow(color: Colors.green, blurRadius: 10)],
              ),
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 20, 54, 64),
                boxShadow: [BoxShadow(color: Colors.green, blurRadius: 12)],
              ),
              padding: EdgeInsets.all(20),
              child: Text(
                discr,
                textAlign: TextAlign.center,
                style: TextStyle(
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
        padding: EdgeInsets.only(bottom: 80),
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
                title: "SELECT ITEMS",
                discr:
                    "our new service make it easy for you to work anywhere ,there are new features will help you"),
            buildPage(
                urlImage: "images/7.png",
                title: "ADD TO CART",
                discr:
                    "our new service make it easy for you to work anywhere ,there are new features will help you"),
            buildPage(
                urlImage: "images/1.png",
                title: "FAST DELIVERY",
                discr:
                    "our new service make it easy for you to work anywhere ,there are new features will help you"),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? Container(
              width: double.infinity,
              // margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 20, 54, 64),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              height: 65,
              child: TextButton(
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool('showHome', true);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
                  },
                  child: Text(
                    "Get Started ",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 66, 252, 169),
                    ),
                  )),
            )
          : Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 20, 54, 64),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => pageController.jumpToPage(2),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Color.fromARGB(255, 66, 252, 169),
                        ),
                      )),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut),
                    effect: WormEffect(
                      spacing: 15,
                      activeDotColor: Color.fromARGB(255, 66, 252, 169),
                    ),
                  ),
                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: Text("Next",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color.fromARGB(255, 66, 252, 169),
                          ))),
                ],
              ),
            ),
    );
  }
}
