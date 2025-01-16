// ignore_for_file: file_names, non_constant_identifier_names, avoid_unnecessary_containers, use_build_context_synchronously, camel_case_types

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'FavoritesController.dart';
import 'LogIn.dart';
import 'Stores.dart';
import 'local/local_controller.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingState();
}

class _SettingState extends State<Settings> {
  File? profileImage;
  MyLocaleController LangController = Get.find();

  Future<void> logOut() async {
    var response = await post(Uri.parse("${baseurl}/api/logout"), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });
    print("Response Status: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print("Success: $responseBody");
    } else {
      print("meeo");
    }
  }

  @override
  void initState() {
    print(prefs!.getString("token"));
    print(prefs!.getString("password"));
    print(prefs!.getInt("userId"));
    fetchProfileImage();
    super.initState();
  }

  String? profileImageUrl;
  String? token = prefs!.getString("token");
  String? userName = prefs!.getString("userName");
  String? email = prefs!.getString("email");
  int? userId = prefs!.getInt("userId");

  Future<void> fetchProfileImage() async {
    final uri = Uri.parse("http://127.0.0.1:8000/getuserimage/$userId");
    try {
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        setState(() {
          profileImageUrl = uri.toString();
        });
        await prefs!.setString('profileImageUrl', profileImageUrl!);
      } else {
        print("Failed to fetch profile image: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching profile image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Setting".tr,
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
        body: Container(
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  Get.to(const ProfilePage());
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 66, 252, 169),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 48, 193, 152),
                            spreadRadius: 2)
                      ]),
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 10, top: 2),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade100,
                        // backgroundImage: const AssetImage("images/logo.png"),
                        backgroundImage: profileImageUrl != null
                            ? NetworkImage(profileImageUrl!)
                            : const AssetImage("images/logo.png"),
                        radius: 45,
                      ),
                      const SizedBox(
                        width: 30,
                        height: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userName!,
                            style: TextStyle(fontSize: 19, color: Colors.blue),
                          ),
                          Text(
                            email!,
                            style: TextStyle(fontSize: 19, color: Colors.blue),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Icon(Icons.edit)
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.only(top: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.language,
                        color: Color.fromARGB(255, 48, 193, 152),
                      ),
                      title: Text(
                        "App Language".tr,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                ),
                onTap: () {
                  Get.bottomSheet(Container(
                    padding: const EdgeInsets.all(10),
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40)),
                    ),
                    child: Column(
                      children: [
                        GetBuilder<MyLocaleController>(
                          builder: (controller) => InkWell(
                            onTap: () {
                              LangController.changeLang("ar");
                              Get.offAll(Stores());
                            },
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              width: double.infinity,
                              child: Container(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.language,
                                      size: 25,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Arabic".tr,
                                      style: const TextStyle(fontSize: 22),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        GetBuilder<MyLocaleController>(
                          builder: (controller) => InkWell(
                            onTap: () {
                              LangController.changeLang("en");
                              Get.offAll(Stores());
                            },
                            child: Container(
                              margin: const EdgeInsets.all(20),
                              width: double.infinity,
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.language,
                                    size: 25,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "English".tr,
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
                },
              ),
              InkWell(
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.only(top: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.password_outlined,
                        color: Color.fromARGB(255, 48, 193, 152),
                      ),
                      title: Text(
                        "Change Password".tr,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                  ),
                ),
                onTap: () {
                  Get.to(() => ChangePassword());
                },
              ),
              InkWell(
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: Container(
                      height: 70,
                      padding: const EdgeInsets.only(top: 8),
                      child: ListTile(
                        leading: const Icon(
                          Icons.contact_page,
                          color: Color.fromARGB(255, 48, 193, 152),
                        ),
                        title: Text(
                          "Contact Us".tr,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const Contact_Us()),
                      )),
              InkWell(
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.only(top: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.face_unlock_rounded,
                        color: Color.fromARGB(255, 48, 193, 152),
                      ),
                      title: Text(
                        "About Us".tr,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                  ),
                ),
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AboutUs())),
              ),
              InkWell(
                child: Card(
                  margin: const EdgeInsets.all(8),
                  child: Container(
                    height: 70,
                    padding: const EdgeInsets.only(top: 8),
                    child: ListTile(
                      leading: const Icon(
                        Icons.logout,
                        color: Color.fromARGB(255, 48, 193, 152),
                      ),
                      title: Text(
                        "Log Out".tr,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                ),
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    descTextStyle: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w400),
                    dialogBorderRadius: BorderRadius.circular(20),
                    desc: 'Are you sure you want to log out?'.tr,
                    btnCancelText: "Cancel".tr,
                    btnOkText: "Ok".tr,
                    btnOkColor: Colors.green,
                    btnCancelColor: Colors.red,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async {
                      logOut();
                      prefs!.setBool('showHome', false);

                      final favoritesController =
                          Get.find<FavoritesController>();
                      await favoritesController.clearFavorites();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OnboardingPage(),
                      ));
                    },
                  ).show();
                },
              ),
            ],
          ),
        ));
  }
}

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 249, 247, 247),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "About Us".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 20, 54, 64),
                  boxShadow: const [
                    BoxShadow(color: Colors.green, blurRadius: 10)
                  ],
                ),
                child: Text(
                  "Nova Cart".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                "images/logo.png",
                height: 240,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 20, 54, 64),
                  boxShadow: const [
                    BoxShadow(color: Colors.green, blurRadius: 12)
                  ],
                ),
                padding: const EdgeInsets.all(7),
                child: Text(
                  "Nova Dis".tr,
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
        ));
  }
}

class Contact_Us extends StatelessWidget {
  const Contact_Us({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 253, 252, 252),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Contact Us".tr),
          backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Image.asset("images/mmm.png"),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.greenAccent),
                height: 55,
                width: 270,
                margin: const EdgeInsets.all(20),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Icon(
                        Icons.phone,
                        size: 35,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 48),
                      child: const Text(
                        "0964652593",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.greenAccent),
                height: 60,
                width: 270,
                margin: const EdgeInsets.all(20),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Icon(
                        Icons.email,
                        size: 35,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 40),
                      child: const Text(
                        "admin@nova_cart.net",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.greenAccent),
                height: 60,
                width: 270,
                margin: const EdgeInsets.all(20),
                child: Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Icon(
                        Icons.facebook,
                        size: 35,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 40),
                      child: const Text(
                        textDirection: TextDirection.ltr,
                        "@Nova Cart",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  File? selectedImage;
  final imagePicker = ImagePicker();
  TextEditingController ChangeUserNameController = TextEditingController();
  Future<File?> uploadImage(ImageSource source) async {
    var pickedImage = await imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
      await prefs!.setString("profileImage", pickedImage.path);
      await uploadToBackend(selectedImage!);
      return File(pickedImage.path); // Return the selected image
    } else {
      return null;
    }
  }

  @override
  void initState() {
    fetchProfileImage();
    print(prefs!.getString("userName"));
    super.initState();
  }

  Future<void> uploadToBackend(File image) async {
    final uri = Uri.parse("http://127.0.0.1:8000/api/changelogo");

    var request = http.MultipartRequest('POST', uri);
    request.fields['userName'] = "$userName";
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.headers['Authorization'] = 'Bearer $token';

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await http.Response.fromStream(response);
        print("Success: ${json.decode(responseBody.body)}");
        print("image upload success");
      } else {
        print("Failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Future<void> fetchProfileImage() async {
    final uri = Uri.parse("http://127.0.0.1:8000/getuserimage/$userId");
    try {
      final response = await http.get(uri, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        setState(() {
          profileImageUrl = uri.toString();
        });
      } else {
        print("Failed to fetch profile image: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching profile image: $e");
    }
  }

  Future<void> updateUserName() async{
    final response = await put(
      Uri.parse("http://127.0.0.1:8000/api/updateusername"),
      headers: {
        'Authorization' : "Bearer $token",
        'Content-Type': 'application/json',
      },
      body:jsonEncode({
      "userName":ChangeUserNameController.text,
    }),
    );
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
    var responseBody = jsonDecode(response.body);
    if(response.statusCode==200){
      print("Success: $responseBody");
      prefs!.setString("userName", ChangeUserNameController.text);
    }else{
      print( "Failed to change User Name: ${response.reasonPhrase}");
    }
  }

  String? number = prefs!.getString("number");
  String? firstName = prefs!.getString("firstName");
  String? lastName = prefs!.getString("lastName");
  String? userName = prefs!.getString("userName");
  String? token = prefs!.getString("token");
  String? profileImageUrl;
  int? userId = prefs!.getInt("userId");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile".tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(255, 20, 54, 64),
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        elevation: 4,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Stack(
              fit: StackFit.passthrough,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade50,
                  radius: 80,
                  backgroundImage: profileImageUrl != null
                      ? NetworkImage(profileImageUrl!) // Show backend image
                      : selectedImage != null
                          ? FileImage(selectedImage!) // Show local image
                          : const AssetImage('images/logo.png'),
                ),
                Positioned(
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.greenAccent,
                    child: IconButton(
                      onPressed: () {
                        Get.bottomSheet(
                            backgroundColor: Colors.white,
                            SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 10),
                                      child: Text(
                                        "Choose Image from:".tr,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        File? image = await uploadImage(
                                            ImageSource.gallery);
                                        if (image != null) {
                                          await uploadToBackend(
                                              image); // Upload the image after selecting
                                        }
                                        Get.back();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(20),
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            const Icon(
                                                Icons.photo_library_outlined,
                                                size: 25),
                                            const SizedBox(width: 20),
                                            Text("Gallery".tr,
                                                style: TextStyle(fontSize: 20)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        File? image = await uploadImage(
                                            ImageSource.camera);
                                        if (image != null) {
                                          await uploadToBackend(
                                              image); // Upload the image after selecting
                                        }
                                        Get.back();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(20),
                                        width: double.infinity,
                                        child: Row(
                                          children: [
                                            const Icon(Icons.camera, size: 25),
                                            const SizedBox(width: 20),
                                            Text("Camera".tr,
                                                style: TextStyle(fontSize: 20)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                      icon: const Icon(Icons.photo_camera, size: 25),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text("User Name".tr, style: TextStyle(color: Colors.grey)),
              trailing: IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                        backgroundColor: Colors.white,
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 10),
                                  child: Center(
                                    child: Text(
                                      "Change User Name".tr,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Form(child: TextFormField(
                                      controller: ChangeUserNameController,
                                       maxLength: 20,
                                      decoration: InputDecoration(prefixIcon: Icon(Icons.perm_identity),label: Text("User Name".tr)),
                                    ))),
                                SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      updateUserName();
                                      Get.offAll(()=>Stores());
                                    }, child: Text("Confirm".tr))
                              ],
                            ),
                          ),
                        ));
                  },
                  icon: Icon(Icons.edit)),
              subtitle: Row(
                children: [
                  Text(userName ?? "", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Divider(height: 10, color: Colors.black26),
            ListTile(
              leading: const Icon(Icons.perm_identity),
              title: Text("Name".tr, style: TextStyle(color: Colors.grey)),
              subtitle: Row(
                children: [
                  Text(firstName ?? "", style: TextStyle(fontSize: 18)),
                  SizedBox(width: 5),
                  Text(lastName ?? "", style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Divider(height: 10, color: Colors.black26),
            ListTile(
              leading: const Icon(Icons.phone),
              title:
                  Text("Phone Number".tr, style: TextStyle(color: Colors.grey)),
              subtitle: Text(number ?? "", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePassword extends StatefulWidget {
  @override
  State<ChangePassword> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  var isobs1;
  var isobs2;
  var isobs3;
  GlobalKey<FormState> ChangePasswordFormKey = GlobalKey();
  final TextEditingController NewPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController OldPasswordController = TextEditingController();

  @override
  void initState() {
    isobs1 = true;
    isobs2 = true;
    isobs3 = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? password = prefs!.getString("password");

  Future<void> changePassword() async {
    String? token = prefs!.getString("token");

    if (token == null) {
      Get.snackbar(
        "Error",
        "User not authenticated.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      final response = await put(
        Uri.parse("http://novacart.test/api/changepassword"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'oldPassword': OldPasswordController.text,
          'newPassword': NewPasswordController.text,
        }),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print("Success: $responseBody");
        Get.back();
      } else {
        Get.snackbar(
          "Error",
          "Failed to change password. Response: ${response.body}",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("Error occurred: $e");
      Get.snackbar(
        "Error",
        "An error occurred. Please check your connection.".tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text("Change Password".tr,
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
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
                key: ChangePasswordFormKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/change.png",
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: OldPasswordController,
                            cursorColor: const Color.fromARGB(255, 20, 54, 64),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            maxLength: 35,
                            obscureText: isobs1,
                            obscuringCharacter: '*',
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    Icons.lock_outline_rounded,
                                    size: 30),
                                prefixIconColor:
                                    const Color.fromARGB(255, 165, 165, 165),
                                labelText: "Old Password".tr,
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 165, 165, 165)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isobs1 = !isobs1;
                                    });
                                  },
                                  icon: isobs1
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(Icons.visibility_off),
                                ),
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
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 23, 7)))),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please enter your password".tr;
                              }
                              if (val != password) {
                                return "Passwords do not match".tr;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: NewPasswordController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: const Color.fromARGB(255, 20, 54, 64),
                            maxLength: 35,
                            obscureText: isobs2,
                            obscuringCharacter: '*',
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    Icons.lock_outline_rounded,
                                    size: 30),
                                prefixIconColor:
                                    const Color.fromARGB(255, 165, 165, 165),
                                labelText: "New Password".tr,
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 165, 165, 165)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isobs2 = !isobs2;
                                    });
                                  },
                                  icon: isobs2
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(Icons.visibility_off),
                                ),
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
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 23, 7)))),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password".tr;
                              } else {
                                if (val.length < 8) {
                                  return "Password must be at least 8 characters"
                                      .tr;
                                }
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: const Color.fromARGB(255, 20, 54, 64),
                            maxLength: 35,
                            obscureText: isobs3,
                            obscuringCharacter: '*',
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                    Icons.lock_outline_rounded,
                                    size: 30),
                                prefixIconColor:
                                    const Color.fromARGB(255, 165, 165, 165),
                                labelText: "Confirm Password".tr,
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 165, 165, 165)),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isobs3 = !isobs3;
                                    });
                                  },
                                  icon: isobs3
                                      ? const Icon(Icons.remove_red_eye)
                                      : const Icon(Icons.visibility_off),
                                ),
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
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 23, 7)))),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please confirm your password".tr;
                              }
                              if (val != NewPasswordController.text) {
                                return "Passwords do not match".tr;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 20, 54, 64),
                            ),
                            onPressed: () async {
                              if (ChangePasswordFormKey.currentState!
                                  .validate()) {
                                await changePassword();
                              } else {
                                Get.snackbar(
                                  "Error".tr,
                                  "Please fill the text fields correctly".tr,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            },
                            child: Text("Change Password".tr,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                  color: Color.fromARGB(255, 66, 252, 169),
                                )),
                          )
                        ]),
                  ),
                ))));
  }
}
