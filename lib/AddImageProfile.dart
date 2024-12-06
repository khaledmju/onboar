import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onboar/Stores.dart';

class AddImageProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddImageProfileState();
  }
}

class AddImageProfileState extends State<AddImageProfile> {
  TextEditingController usernameController = TextEditingController();

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
      appBar: AppBar(
        title: const Text(
          "Profile Image",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 70,),
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
            SizedBox(height: 60,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 35),
              child: TextFormField(
                // controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Color.fromARGB(255, 20, 54, 64),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.perm_identity, size: 30),
                    prefixIconColor: const Color.fromARGB(255, 165, 165, 165),
                    labelText: "User Name",
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
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  backgroundColor: Color.fromARGB(255, 20, 54, 64),
                ),
                onPressed: () {
                },
                child: Icon(Icons.location_on_outlined,color: Color.fromARGB(255, 66, 252, 169),)),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  backgroundColor: Color.fromARGB(255, 20, 54, 64),
                ),
                onPressed: () {
                  Get.offAll(Stores());
                },
                child: Icon(Icons.arrow_forward_sharp,color: Color.fromARGB(255, 66, 252, 169),))
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
