// ignore_for_file: file_names, unused_import, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:onboar/Driver.dart';
import 'AddImageProfile.dart';
import 'SignUp.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'Stores.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isobs;

  @override
  void initState() {
    isobs = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isEmail(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Log In".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromARGB(255, 20, 54, 64),
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal)),
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        elevation: 4,
        centerTitle: true,
        shadowColor: const Color.fromARGB(255, 48, 193, 152),
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
              margin: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 10,
                      controller: numberController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: const Color.fromARGB(255, 20, 54, 64),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone, size: 30),
                          prefixIconColor:
                              const Color.fromARGB(255, 165, 165, 165),
                          labelText: "Phone Number".tr,
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 165, 165, 165)),
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

                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter your Phone Number".tr;
                        }
                        else {
                          if (!val.startsWith('09')) {
                            return "Phone Number must be : 09XXXXXXXX".tr;
                          }
                          else if (val.length < 10 || val.length > 10) {
                            return "Phone Number must be 10 digits".tr;
                          } else if (val.hashCode.isNaN) {
                            return "Phone Number must ONLY contain numbers".tr;
                          }
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: const Color.fromARGB(255, 20, 54, 64),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail_outlined, size: 30),
                          prefixIconColor:
                              const Color.fromARGB(255, 165, 165, 165),
                          labelText: "Email Address".tr,
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(255, 165, 165, 165)),
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
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return null;
                        }
                        if (isEmail(val) == false) {
                          return "Email is not valid".tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      cursorColor: const Color.fromARGB(255, 20, 54, 64),
                      maxLength: 35,
                      obscureText: isobs,
                      obscuringCharacter: '*',
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.lock_outline_rounded, size: 30),
                          prefixIconColor:
                              const Color.fromARGB(255, 165, 165, 165),
                          labelText: "Password".tr,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isobs = !isobs;
                              });
                            },
                            icon: isobs
                                ? const Icon(Icons.remove_red_eye)
                                : const Icon(Icons.visibility_off),
                          ),
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
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Please enter your password".tr;
                        } else {
                          if (val.length < 8) {
                            return "Password must be at least 8 characters".tr;
                          }
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("you dont have an account?".tr,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: Color.fromARGB(255, 20, 54, 64))),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ));
                            },
                            child: Text("Sign Up".tr,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 20, 54, 64),
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            final response = await post(
                              Uri.parse("http://127.0.0.1:8000/api/login"),
                              headers: {'Content-Type': 'application/json'},
                              body: jsonEncode({
                                "number": numberController.text,
                                "email": emailController.text,
                                "password": passwordController.text,
                              }),
                            ).timeout(Duration(seconds: 30));
                            if (response.statusCode == 200) {
                              var responseBody = jsonDecode(response.body);
                              if (responseBody["success"] == "true") {
                                await prefs!.setBool('showHome', true);
                                // print(responseBody["token"]);
                                await prefs!
                                    .setString("token", responseBody["token"]);
                                await prefs!.setString("userName",
                                    responseBody["user"]["userName"]);
                                await prefs!.setString(
                                    "number", responseBody["user"]["number"]);
                                await prefs!.setString("firstName",
                                    responseBody["user"]["firstName"]);
                                await prefs!.setString("lastName",
                                    responseBody["user"]["lastName"]);
                                await prefs!.setString(
                                    "email", responseBody["user"]["email"]);
                                await prefs!.setString(
                                    "password", passwordController.text);
                                await prefs!.setInt(
                                    "userId", responseBody["user"]["id"]);
                                if (responseBody["user"]["isDriver"] == 1) {
                                  await prefs!.setBool("isDriver", true);
                                  print("Success: $responseBody");
                                  Get.offAll(() => Driver());
                                } else {
                                  await prefs!.setBool("isDriver", false);
                                  print("Success: $responseBody");
                                  Get.offAll(() => Stores());
                                }
                              } else {
                                Get.snackbar(
                                  "Error",
                                  titleText: Text(
                                    "Error",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.yellow),
                                  ),
                                  responseBody["reason"],
                                  padding: EdgeInsets.all(30),
                                  messageText: Text(
                                    responseBody["reason"],
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  backgroundColor: Colors.red,
                                  snackPosition: SnackPosition.BOTTOM,
                                  icon: const Icon(
                                    Icons.warning_amber,
                                    color: Colors.yellow,
                                    size: 40,
                                  ),
                                );
                              }
                            } else {
                              print(
                                  "Login failed: ${response.statusCode} - ${response.reasonPhrase}");
                            }
                          } catch (e) {
                            if (e is ClientException) {
                              print("Network error: ${e.message}");
                            } else {
                              print("Error: $e");
                            }
                          }
                        } else {
                          Get.snackbar(
                            "Validation Error".tr,
                            "Please fill the text fields correctly".tr,
                            backgroundColor: Colors.red,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      child: Text(
                        "Log In".tr,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 66, 252, 169),
                        ),
                      ),
                    ),
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
