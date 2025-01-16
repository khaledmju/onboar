// ignore_for_file: unused_import, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:http/http.dart';

import 'ProductsPage.dart';
import 'main.dart';

class ProductDetailsPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final Map<String, dynamic> productData;
  final Uint8List? productImage;

  const ProductDetailsPage(
      {super.key, required this.productData, this.productImage});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPage();
}

class _ProductDetailsPage extends State<ProductDetailsPage> {
  int count = 0;

  bool isArabic() {
    return Get.locale?.languageCode == 'ar';
  }

  Uint8List? productImage;
  String? token = prefs!.getString("token");

  Future<void> fetchImage() async {
    try {
      var response = await get(
        Uri.parse(
            "http://127.0.0.1:8000/api/getproductimage/${widget.productData['id']}"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          productImage = response.bodyBytes;
        });
      } else {
        print("Failed to fetch image: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching image: $e");
    }
  }

  Future<void> addItem() async {
    try {
      var response = await post(Uri.parse("http://127.0.0.1:8000/api/additem"),
          headers: {
            'Authorization': "Bearer $token",
            'Content-Type': 'application/json',
          },
          body: jsonEncode(
              {"product_id": widget.productData["id"], "quantity": count}));
      var responseBody = response.body;
      if (response.statusCode == 200) {
        print(responseBody);
        print("${widget.productData["id"]}");
        Get.snackbar(
          "",
          "",
          titleText: Center(
              child: Text(
            "Product added to cart",
            style: TextStyle(fontSize: 20),
          )),
          backgroundColor: Colors.greenAccent,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar("Error", "Failed to add product ");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred");
      print("Error adding product : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text("${widget.productData['name']}",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromARGB(255, 20, 54, 64),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal)),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        elevation: 4,
        shadowColor: const Color.fromARGB(255, 48, 193, 152),
      ),
      body: Container(
          color: Colors.white,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  widget.productImage != null
                      ? Image.memory(
                          widget.productImage!,
                          height: 230,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "images/prod.png",
                          height: 230,
                          fit: BoxFit.cover,
                        ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 66, 252, 169),
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // height: 70,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "${widget.productData['name']}",
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 20, 54, 64)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 66, 252, 169),
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      textAlign: TextAlign.center,
                      "${widget.productData['description']}",
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: isArabic()
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          children: [
                            Text(
                              "  ${widget.productData['quantity']<1?0:widget.productData['quantity']}  ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const Text(
                              ":",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(
                              "Quantity".tr,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: isArabic()
                              ? TextDirection.ltr
                              : TextDirection.rtl,
                          children: [
                            Text(
                              "\$",
                              style: TextStyle(fontSize: 22),
                            ),
                            Text(
                              "  ${widget.productData['price']}  ",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            const Text(
                              ":",
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Text(
                              "Price".tr,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: count > 0
                            ? () {
                                setState(() {
                                  count--;
                                });
                              }
                            : null,
                        icon: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red,
                          size: 30,
                        )),
                    Text(
                      "$count",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    IconButton(
                        onPressed: count < widget.productData['quantity']
                            ? () {
                                setState(() {
                                  count++;
                                });
                              }
                            : null,
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: count < widget.productData['quantity']
                              ? const Color.fromARGB(255, 66, 252, 169)
                              : Colors.grey,
                          size: 30,
                        )),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: count > 0
                        ? () {
                            addItem();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 20, 54, 64),
                        padding: const EdgeInsets.symmetric(horizontal: 40)),
                    child: Text("Add to Cart".tr,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: Color.fromARGB(255, 66, 252, 169),
                        ))),
              )
            ],
          )),
    );
  }
}
