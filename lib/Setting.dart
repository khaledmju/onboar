import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboar/local/local_contorller.dart';
import 'package:onboar/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class Setting extends StatefulWidget {
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  MyLocaleController LangController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Setting".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
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
                  Get.to(ProfilePage());
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
                  margin: EdgeInsets.only(bottom: 10, top: 2),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade100,
                        backgroundImage: AssetImage("images/logo.png"),
                        radius: 45,
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("",style: TextStyle(fontSize: 19,color: Colors.blue),),
                          SizedBox(
                            height: 8,
                          ),
                          Text("",style: TextStyle(fontSize: 19,color: Colors.blue),),

                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Card(
                  margin: EdgeInsets.all(8),
                  child: Container(
                    height: 70,
                    padding: EdgeInsets.only(top: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.language,
                        color:  Color.fromARGB(255, 48, 193, 152),
                      ),
                      title: Text(
                        "App Language".tr,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                ),
                onTap: () {
                  Get.bottomSheet(Container(
                    padding: EdgeInsets.all(10),
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40)),
                    ),
                    child: Column(
                      children: [
                        GetBuilder<MyLocaleController>(builder:(controller) =>InkWell(
                          onTap: () {
                            LangController.changeLang("ar");
                          },
                          child: Container(
                            margin: EdgeInsets.all(20),
                            width: double.infinity,
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.language,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Arabic".tr,
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),),
                      GetBuilder<MyLocaleController>(builder:(controller) => InkWell(
                        onTap: () {
                          LangController.changeLang("en");
                        },
                        child: Container(
                          margin: EdgeInsets.all(20),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Icon(
                                Icons.language,
                                size: 25,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "English".tr,
                                style: TextStyle(fontSize: 22),
                              ),
                            ],
                          ),
                        ),
                      ),),

                      ],
                    ),
                  ));
                },


              ),
              InkWell(
                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: Container(
                      height: 70,
                      padding: EdgeInsets.only(top: 8),
                      child: ListTile(
                        leading: Icon(
                          Icons.contact_page,
                          color:  Color.fromARGB(255, 48, 193, 152),
                        ),
                        title: Text(
                          "Contact Us".tr,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: Icon(Icons.chevron_right),
                      ),
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Contact_Us()),
                      )),
              InkWell(
                child: Card(
                  margin: EdgeInsets.all(8),
                  child: Container(
                    height: 70,
                    padding: EdgeInsets.only(top: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.face_unlock_rounded,
                        color:  Color.fromARGB(255, 48, 193, 152),
                      ),
                      title: Text(
                        "About Us".tr,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.chevron_right_rounded),
                    ),
                  ),
                ),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AboutUs())),
              ),
              InkWell(
                child: Card(
                  margin: EdgeInsets.all(8),
                  child: Container(
                    height: 70,
                    padding: EdgeInsets.only(top: 8),
                    child: ListTile(
                      leading: Icon(
                        Icons.logout,
                        color:  Color.fromARGB(255, 48, 193, 152),
                      ),
                      title: Text(
                        "Log Out".tr,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                ),
                onTap: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.question,
                    descTextStyle:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                    dialogBorderRadius: BorderRadius.circular(20),
                    desc: 'Are you sure you want to log out?'.tr,
                    btnCancelText: "Cancel".tr,
                    btnOkText: "Ok".tr,
                    btnOkColor: Colors.green,
                    btnCancelColor: Colors.red,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool('showHome', false);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OnboardingPage(),
                      ));
                    },
                  ).show();
                },
              ),
              // ElevatedButton(onPressed: () {
              //   if(Get.isDarkMode){
              //     Get.changeTheme(ThemeData.light());
              //   }else{
              //     Get.changeTheme(ThemeData.dark());
              //   }
              // }, child: Text("Change Theme")),
            ],
          ),
        ));
  }
}

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 249, 247, 247),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "About Us".tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  "Nova Cart".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "images/logo.png",
                height: 240,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 20, 54, 64),
                  boxShadow: [BoxShadow(color: Colors.green, blurRadius: 12)],
                ),
                padding: EdgeInsets.all(7),
                child: Text(
                  "Nova Dis".tr,
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
        ));
  }
}

class Contact_Us extends StatelessWidget {
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
                margin: EdgeInsets.only(bottom: 20),
                child: Image.asset("images/mmm.png"),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.greenAccent),
                height: 55,
                width: 270,
                margin: EdgeInsets.all(20),
                child: Row(
                  textDirection:TextDirection.ltr ,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.phone,
                        size: 35,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 48),
                      child: Text(
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
                margin: EdgeInsets.all(20),
                child: Row(
                  textDirection:TextDirection.ltr ,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.email,
                        size: 35,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
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
                margin: EdgeInsets.all(20),
                child: Row(
                  textDirection:TextDirection.ltr ,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.facebook,
                        size: 35,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        textDirection:TextDirection.ltr ,
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
  @override
  State<StatefulWidget> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile",
            textAlign: TextAlign.center,
            style: TextStyle(
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
        child: Column(
          children: [
            // SizedBox(
            //   height: 50,
            // ),
            // CircleAvatar(
            //   backgroundColor: Colors.grey.shade100,
            //   backgroundImage: AssetImage("images/logo.png"),
            //   radius: 75,
            // ),
            SizedBox(
              height: 70,
            ),
            Stack(
              fit: StackFit.passthrough,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade50,
                  radius: 80,
                  backgroundImage: Slectedimage != null
                      ? FileImage(Slectedimage!)
                      : const AssetImage('images/logo.png'),
                ),
                Positioned(
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.greenAccent,
                    child: IconButton(
                      onPressed: () {
                        ShowButtomSheet();
                      },
                      icon: Icon(
                        Icons.photo_camera,
                        size: 25,
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ListTile(
              onTap: () {
                Get.bottomSheet(Container(
                  padding: EdgeInsets.only(top: 20),
                  width: double.infinity,
                  height: 200,
                  color: Colors.white,
                  child: TextFormField(),
                ));
              },
              leading: Icon(Icons.perm_identity),
              trailing: Icon(
                Icons.edit,
                color: Colors.green,
              ),
              title: Text(
                "name",
                style: TextStyle(color: Colors.grey),
              ),
              isThreeLine: true,
              subtitle: Text(
                "User Name",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ShowButtomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    "Chose Image from:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    uploadImage(ImageSource.gallery);
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.photo_library_outlined,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Gellary",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    uploadImage(ImageSource.camera);
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "camera",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
