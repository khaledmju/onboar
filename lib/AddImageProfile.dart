// ignore_for_file: file_names, use_key_in_widget_constructors, non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'Stores.dart';

class AddImageProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddImageProfileState();
  }
}

class AddImageProfileState extends State<AddImageProfile> {
  TextEditingController usernameController = TextEditingController();

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
            const SizedBox(height: 70,),
            Stack(
              fit: StackFit.passthrough,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey.shade50,
                  radius: 80,
                  backgroundImage: selectedImage != null
                      ? FileImage(selectedImage!)
                      : const AssetImage('images/logo.png'),
                ),
                Positioned(
                  bottom: 0,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.greenAccent,
                    child: IconButton(
                      onPressed: () {
                        ShowBottomSheet();
                      },
                      icon: const Icon(
                        Icons.photo_camera,
                        size: 25,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 35),
              child: TextFormField(
                // controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: const Color.fromARGB(255, 20, 54, 64),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.perm_identity, size: 30),
                    prefixIconColor: const Color.fromARGB(255, 165, 165, 165),
                    labelText: "User Name",
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
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  backgroundColor: const Color.fromARGB(255, 20, 54, 64),
                ),
                onPressed: () {
                },
                child: const Icon(Icons.location_on_outlined,color: Color.fromARGB(255, 66, 252, 169),)),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  backgroundColor: const Color.fromARGB(255, 20, 54, 64),
                ),
                onPressed: () {
                  Get.offAll(const Stores());
                },
                child: const Icon(Icons.arrow_forward_sharp,color: Color.fromARGB(255, 66, 252, 169),))
          ],
        ),
      ),
    );
  }
  ShowBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: const Text(
                    "Chose Image from:",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                  onTap: () {
                    uploadImage(ImageSource.gallery);
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.photo_library_outlined,
                          size: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Gallery",
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
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    child: const Row(
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
