// ignore_for_file: file_names, unused_import, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddImageProfile.dart';
import 'LogIn.dart';
import 'Stores.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  File? selectedImage;

  final imagePicker = ImagePicker();

  uploadImage(ImageSource) async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    } else {}
  }

  GlobalKey<FormState> formKey = GlobalKey();

  bool isEmail(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("Sign Up".tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromARGB(255, 20, 54, 64),
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        elevation: 4,
        shadowColor: const Color.fromARGB(255, 48, 193, 152),
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Image.asset(
              "images/cs.png",
              width: 220,
              height: 220,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: firstNameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: const Color.fromARGB(255, 20, 54, 64),
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          // onSaved: (val){username = val;},
                          decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.perm_identity, size: 30),
                              prefixIconColor:
                                  const Color.fromARGB(255, 165, 165, 165),
                              labelText: "First Name".tr,
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 165, 165, 165)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 66, 252, 169))),
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
                              return "Please enter your First Name".tr;
                            } else {
                              if (val.length < 3) {
                                return "First Name must be longer than 3 characters"
                                    .tr;
                              } else if (val.length > 20) {
                                return "First Name must be shorter than 20 characters"
                                    .tr;
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(left: 10, right: 10)),
                      Expanded(
                        child: TextFormField(
                          controller: lastNameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          cursorColor: const Color.fromARGB(255, 20, 54, 64),
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          // onSaved: (val){username = val;},
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                  Icons.family_restroom_outlined,
                                  size: 30),
                              prefixIconColor:
                                  const Color.fromARGB(255, 165, 165, 165),
                              labelText: "Last Name".tr,
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 165, 165, 165)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 66, 252, 169))),
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
                                  borderSide:
                                      const BorderSide(color: Color.fromARGB(255, 255, 23, 7)))),

                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter your Last Name".tr;
                            } else {
                              if (val.length < 3) {
                                return "Last Name must be longer than 3 characters"
                                    .tr;
                              } else if (val.length > 20) {
                                return "Last Name must be shorter than 20 characters"
                                    .tr;
                              }
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: userNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: const Color.fromARGB(255, 20, 54, 64),
                    obscureText: false,
                    // onSaved: (val){phoneNumber = val;},
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.perm_identity, size: 30),
                        prefixIconColor:
                            const Color.fromARGB(255, 165, 165, 165),
                        labelText: "User Name".tr,
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
                        return "Please enter your User Name".tr;
                      } else {
                        if (val.length < 3) {
                          return "User Name must be longer than 3 characters".tr;
                        } else if (val.length > 20) {
                          return "User Name must be shorter than 20 characters".tr;
                        }
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: numberController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: const Color.fromARGB(255, 20, 54, 64),
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    // onSaved: (val){phoneNumber = val;},
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone, size: 30),
                        prefixIconColor:
                            const Color.fromARGB(255, 165, 165, 165),
                        labelText: "Number".tr,
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
                      } else {
                        if (!val.startsWith('09')) {
                          return "Phone Number must be : 09XXXXXXXX".tr;
                        }else if (val.length < 10 || val.length > 10) {
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
                      if (isEmail(val!) == false) {
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
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 165, 165, 165)),
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
                        return "Please enter your Password".tr;
                      } else {
                        if (val.length < 8) {
                          return "Password must be at least 8 characters".tr;
                        }
                        return null;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?".tr,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: Color.fromARGB(255, 20, 54, 64))),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Home()));
                          });
                        },
                        child: Text("Log In".tr,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          final response = await post(
                            Uri.parse("http://novacart.test/api/signup"),
                            headers: {
                              'Content-Type': 'application/json',
                            },
                            body: jsonEncode({
                              "firstName": firstNameController.text,
                              "lastName": lastNameController.text,
                              "userName": userNameController.text,
                              "number": numberController.text,
                              "email": emailController.text,
                              "logo": "http://",
                              "location": "location",
                              "password": passwordController.text,
                            }),
                          );

                          print("Response status: ${response.statusCode}");
                          print("Response body: ${response.body}");
                          var responseBody = jsonDecode(response.body);
                          if (response.statusCode == 200) {
                              print("Success: $responseBody");
                              final prefs =
                              await SharedPreferences.getInstance();
                              await prefs.setBool('showHome', true);
                              Get.offAll(() => Stores());

                          } else {
                            print(
                                "Failed to sign up: ${response.reasonPhrase}");
                            Map<String, String> fieldLabels = {
                              "email": "Email",
                              "userName": "Username",
                              "number": "Number"
                            };
                            String errorMessage = "";
                            responseBody["errors"]?.forEach((key, value) {
                              if (value.isNotEmpty) {
                                errorMessage = "${fieldLabels[key]} is ${value.first}";
                              }
                            });

                            if (errorMessage.isNotEmpty) {
                              Get.snackbar(
                                padding: EdgeInsets.all(30),
                                "Error",
                                "",
                                titleText: Text("Error",style: TextStyle(fontSize: 22,color: Colors.yellow),),
                                messageText: Text(
                                  errorMessage,
                                  style: TextStyle(fontSize: 22),
                                ),
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                icon: const Icon(
                                  Icons.warning_amber,
                                  color: Colors.yellow,
                                  size: 40,
                                ),
                              );
                            }

                            ErrorHint(
                                "Failed to sign up: ${response.reasonPhrase}");
                          }
                        } catch (e) {
                          print("Error: $e");
                          ErrorHint(
                              "An error occurred. Please try again later.");
                        }
                      } else {
                        Get.snackbar(
                          "Validation Error",
                          "Please fill the text fields correctly.",
                          backgroundColor: Colors.red,
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 20, 54, 64),
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                    ),
                    child: Text(
                      "Sign Up".tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
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
    );
  }
}
