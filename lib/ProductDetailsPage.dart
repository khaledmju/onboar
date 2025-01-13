// ignore_for_file: unused_import, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';

import 'ProductsPage.dart';

class ProductDetailsPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final productData;

  const ProductDetailsPage({super.key, this.productData});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPage();
}

class _ProductDetailsPage extends State<ProductDetailsPage> {
  int count = 0;

  bool isArabic() {
    return Get.locale?.languageCode == 'ar';
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
                  Image.asset(
                    "images/prod.png",
                    height: 230,
                    fit: BoxFit.cover,
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
                    margin: EdgeInsets.only(left: 20,right: 20,top: 10),
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
                          fontWeight: FontWeight.w400,),
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
                              "  ${widget.productData['quantity']}  ",
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
                        onPressed: count<widget.productData['quantity']? () {
                          setState(() {
                            count++;
                          });
                        }:null,
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: count<widget.productData['quantity']? const Color.fromARGB(255, 66, 252, 169)
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
                            // Add to cart logic
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
