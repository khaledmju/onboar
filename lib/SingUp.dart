import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboar/AddImageProfile.dart';
import 'package:onboar/Home.dart';
import 'package:onboar/Stores.dart';
import 'package:image_picker/image_picker.dart';


final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();
final TextEditingController numberController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  File? Slectedimage;

  final imagepicker = ImagePicker();

  uploadImage(ImageSource) async {
    var pickedImage = await imagepicker.pickImage(source: ImageSource);
    if (pickedImage != null) {
      setState(() {
        Slectedimage = File(pickedImage.path);
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
        title: const Text("Sing Up",
            textAlign: TextAlign.center,
            style: TextStyle(
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
              width: 250,
              height: 250,
            ),
          ),
          // SizedBox(height: 20,),
          // Stack(
          //   fit: StackFit.passthrough,
          //   children: [
          //     CircleAvatar(
          //       backgroundColor: Colors.grey.shade100,
          //       radius: 80,
          //       backgroundImage: Slectedimage != null
          //           ? FileImage(Slectedimage!)
          //           : const AssetImage('images/logo.png'),
          //     ),
          //     Positioned(
          //       bottom: 0,
          //       child: CircleAvatar(
          //         radius: 25,
          //         backgroundColor: Colors.greenAccent,
          //         child: IconButton(
          //           onPressed: () {
          //             ShowButtomSheet();
          //           },
          //           icon: Icon(
          //             Icons.photo_camera,
          //             size: 25,
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.only(bottom: 20,left: 20,right: 20),
            child: Form(
              key : formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: firstNameController,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          cursorColor: Color.fromARGB(255, 20, 54, 64),
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          // onSaved: (val){username = val;},
                          decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.perm_identity, size: 30),
                              prefixIconColor:
                                  const Color.fromARGB(255, 165, 165, 165),
                              labelText: "First Name",
                              hintStyle: TextStyle(
                                  color: const Color.fromARGB(
                                      255, 165, 165, 165)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 66, 252, 169))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 20, 54, 64))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 23, 7))),
                              focusedErrorBorder:
                                  OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color.fromARGB(255, 255, 23, 7)))),

                          // validator: (val) {
                          //   if (val!.isEmpty) {
                          //     return "Please enter your First Name";
                          //   } else {
                          //     if (val.length < 3) {
                          //       return "First Name must be longer than 3 characters";
                          //     } else if (val.length > 20) {
                          //       return "First Name must be shorter than 20 characters";
                          //     }
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10, right: 10)),
                      Expanded(
                        child: TextFormField(
                          controller: lastNameController,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          cursorColor: Color.fromARGB(255, 20, 54, 64),
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          // onSaved: (val){username = val;},
                          decoration: InputDecoration(
                              prefixIcon: const Icon(
                                  Icons.family_restroom_outlined,
                                  size: 30),
                              prefixIconColor:
                                  const Color.fromARGB(255, 165, 165, 165),
                              labelText: "Last Name",
                              hintStyle: TextStyle(
                                  color: const Color.fromARGB(
                                      255, 165, 165, 165)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 66, 252, 169))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 20, 54, 64))),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide:
                                      const BorderSide(color: Color.fromARGB(255, 255, 23, 7))),
                              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Color.fromARGB(255, 255, 23, 7)))),

                          // validator: (val) {
                          //   if (val!.isEmpty) {
                          //     return "Please enter your Last Name";
                          //   } else {
                          //     if (val.length < 3) {
                          //       return "Last Name must be longer than 3 characters";
                          //     } else if (val.length > 20) {
                          //       return "Last Name must be shorter than 20 characters";
                          //     }
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // TextFormField(
                  //   controller: numberController,
                  //   autovalidateMode: AutovalidateMode.onUserInteraction,
                  //   cursorColor: Color.fromARGB(255, 20, 54, 64),
                  //   obscureText: false,
                  //   keyboardType: TextInputType.number,
                  //   // onSaved: (val){phoneNumber = val;},
                  //   decoration: InputDecoration(
                  //       prefixIcon: const Icon(Icons.perm_identity, size: 30),
                  //       prefixIconColor:
                  //       const Color.fromARGB(255, 165, 165, 165),
                  //       labelText: "User Name",
                  //       hintStyle: TextStyle(
                  //           color: const Color.fromARGB(255, 165, 165, 165)),
                  //       focusedBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(6),
                  //           borderSide: const BorderSide(
                  //               color: Color.fromARGB(255, 66, 252, 169))),
                  //       enabledBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(6),
                  //           borderSide: const BorderSide(
                  //               color: Color.fromARGB(255, 20, 54, 64))),
                  //       errorBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(6),
                  //           borderSide: const BorderSide(
                  //               color: Color.fromARGB(255, 255, 23, 7))),
                  //       focusedErrorBorder: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(6),
                  //           borderSide: const BorderSide(
                  //               color: Color.fromARGB(255, 255, 23, 7)))),
                  //
                  //   // validator: (val) {
                  //   //   if (val!.isEmpty) {
                  //   //     return "Please enter your Phone Number";
                  //   //   } else {
                  //   //     if (val.length < 10 || val.length > 10) {
                  //   //       return "Phone Number must be 10 digits";
                  //   //     } else if (!val.startsWith('09')) {
                  //   //       return "Phone Number must be : 09XXXXXXXX";
                  //   //     } else if (val.hashCode.isNaN) {
                  //   //       return "Phone Number must ONLY contain numbers";
                  //   //     }
                  //   //     return null;
                  //   //   }
                  //   // },
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: numberController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: Color.fromARGB(255, 20, 54, 64),
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    // onSaved: (val){phoneNumber = val;},
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone, size: 30),
                        prefixIconColor:
                            const Color.fromARGB(255, 165, 165, 165),
                        labelText: "Number",
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

                    // validator: (val) {
                    //   if (val!.isEmpty) {
                    //     return "Please enter your Phone Number";
                    //   } else {
                    //     if (val.length < 10 || val.length > 10) {
                    //       return "Phone Number must be 10 digits";
                    //     } else if (!val.startsWith('09')) {
                    //       return "Phone Number must be : 09XXXXXXXX";
                    //     } else if (val.hashCode.isNaN) {
                    //       return "Phone Number must ONLY contain numbers";
                    //     }
                    //     return null;
                    //   }
                    // },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                    // validator: (val) {
                    //   if (val!.isEmpty) {
                    //     return "Please enter your Email Address";
                    //   } else {
                    //     if (isEmail(val) == false) {
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
                    obscureText: isobs,
                    obscuringCharacter: '*',
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.lock_outline_rounded, size: 30),
                        prefixIconColor:
                            const Color.fromARGB(255, 165, 165, 165),
                        labelText: "Password",
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 165, 165, 165)),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isobs = !isobs;
                            });
                          },
                          icon: isobs
                              ? Icon(Icons.remove_red_eye)
                              : Icon(Icons.visibility_off),
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
                    // validator: (val) {
                    //   if (val!.isEmpty) {
                    //     return "Please enter your Password";
                    //   } else {
                    //     if (val.length < 8) {
                    //       return "Password must be at least 8 characters";
                    //     }
                    //     return null;
                    //   }
                    // },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? ",
                          style: TextStyle(
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
                        child: const Text("Log In",
                            style: TextStyle(
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
                      Get.offAll(Stores());
                      // Get.offAll(AddImageProfile());
                      // setState(() {
                      //   if (formKey.currentState!.validate()) {
                      //     // content = sharedPreferences.setStringList('items', <String>[usernameController.toString(),numberController.toString(),emailController.toString(),passwordController.toString()]);
                      //     // User user = User(content.indexOf(0) as String,content.indexOf(1) as String,content.indexOf(2) as String,content.indexOf(3) as String);
                      //     // sharedPreferences.setStringList('user',json.encode(user.toJson()));
                      //
                      //     // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>  Start_Application()));
                      //   } else {
                      //     ErrorHint("Please fill the Text Fields correctly");
                      //   }
                      // });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 20, 54, 64),
                        padding: EdgeInsets.symmetric(horizontal: 100)),
                    child: const Text("Sign Up",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color.fromARGB(255, 66, 252, 169),
                        )),
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
