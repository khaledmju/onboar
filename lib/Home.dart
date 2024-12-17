import 'package:flutter/material.dart';
import 'package:onboar/AddImageProfile.dart';
import 'package:onboar/SingUp.dart';
import 'package:onboar/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:onboar/Stores.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isobs;
  @override
  void initState() {
    isobs = true;
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
  }
  bool isEmail(String email) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Log In" , textAlign: TextAlign.center,
            style : TextStyle(color : Color.fromARGB(255, 20, 54, 64) ,fontSize: 26 , fontWeight: FontWeight.bold , fontStyle: FontStyle.normal)),
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        elevation: 4,
        centerTitle: true,
        shadowColor: const Color.fromARGB(255, 48, 193, 152),
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         final prefs = await SharedPreferences.getInstance();
        //         prefs.setBool('showHome', false);
        //         Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => OnboardingPage(),
        //         ));
        //       },
        //       icon: Icon(Icons.logout)),
        // ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

            const SizedBox(
              height: 40,
            ),
            Center(
              child: Image.asset(
                "images/3.png",
                width: 250,
                height: 250,
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Color.fromARGB(255, 20, 54, 64),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail_outlined, size: 30),
                          prefixIconColor:
                          const Color.fromARGB(255, 165, 165, 165),
                          labelText: "Email Address",
                          hintStyle: TextStyle(
                              color: const Color.fromARGB(255, 165, 165, 165)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 66, 252, 169))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 20, 54, 64))),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 23, 7))),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 23, 7)))),
                      // validator: (val){
                      //   if(val!.isEmpty){
                      //     return "Please enter your Email Address";
                      //   }
                      //   else{
                      //     if(isEmail(val)==false){
                      //       return "Email is not valid";
                      //     }
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: Color.fromARGB(255, 20, 54, 64),
                      maxLength: 35,
                      obscureText : isobs,
                      obscuringCharacter: '*',
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline_rounded , size : 30),
                          prefixIconColor: const Color.fromARGB(255, 165, 165, 165),
                          labelText: "password",
                          suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  isobs = ! isobs;
                                });
                              }, icon: isobs ?  Icon(Icons.remove_red_eye) : Icon(Icons.visibility_off),),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color : Color.fromARGB(255, 66, 252, 169))
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color : Color.fromARGB(255, 20, 54, 64))
                          ),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color : Color.fromARGB(255, 255, 23, 7))
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: const BorderSide(color : Color.fromARGB(255, 255, 23, 7))
                          )
                      ),
                      // validator: (val){
                      //   if(val!.isEmpty){
                      //     return "Please enter your Password";
                      //   }
                      //   else{
                      //     if(val.length < 8){
                      //       return "Password must be at least 8 characters";
                      //     }
                      //     return null;
                      //   }
                      // },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("you dont have an account?",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: Color.fromARGB(255, 20, 54, 64))),
                        TextButton(
                            onPressed: () {
                              // Navigator.of(context).pushNamed("Login");
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp(),));
                            },
                            child: const Text("Singup",style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w400))),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 20, 54, 64),padding: EdgeInsets.symmetric(horizontal: 100)),onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>det(name: username.text, email: email.text, phone: phone.text) ,));
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Stores()));
                      Get.offAll(Stores());
                      // Get.offAll(AddImageProfile());
                    }, child: Text("Login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color.fromARGB(255, 66, 252, 169),))),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
