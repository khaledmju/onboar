import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:http/http.dart';
import 'package:onboar/PaymentMethod.dart';

import 'ProductsPage.dart';
import 'main.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CartState();
}

class CartState extends State<Cart> {
  List<dynamic> cartProducts = [];

  bool isArabic() {
    return Get.locale?.languageCode == 'ar';
  }

  String? token = prefs!.getString("token");

  Future<void> getCart() async {
    try {
      var response =
          await get(Uri.parse("http://127.0.0.1:8000/api/getcart"), headers: {
        'Authorization': "Bearer $token",
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        setState(() {
          cartProducts = responseBody;
        });
        for (var product in cartProducts) {
          fetchImage(product);
        }

      } else {
        print("Failed to load cart : ${response.statusCode}");
      }
    } catch (e) {
      print("Error : $e");
    }
  }

  Future<void> fetchImage(dynamic product) async {
    try {
      var response = await get(
        Uri.parse("http://127.0.0.1:8000/api/getproductimage/${product['product_id']}"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          product['image'] = response.bodyBytes; // Store image bytes
        });
      } else {
        print("Failed to fetch image: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching image: $e");
    }
  }



  Future<void> deleteCart() async {
    try {
      var response = await delete(
          Uri.parse("http://127.0.0.1:8000/api/deletecart"),
          headers: {
            'Authorization': "Bearer $token",
            'Content-Type': 'application/json',
          });
      var responseBody = response.body;
      if (response.statusCode == 200) {
        print(responseBody);
        Get.snackbar(
          "",
          "",
          titleText: Center(
              child: Text(
            "Cart deleted".tr,
            style: TextStyle(fontSize: 20),
          )),
          backgroundColor: Colors.greenAccent,
        );
        setState(() {
          cartProducts = [];
        });
        await getCart();
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> deleteCartElement(int prodcutId) async {
    try {
      var response = await delete(
          Uri.parse("http://127.0.0.1:8000/api/deletecart"),
          headers: {
            'Authorization': "Bearer $token",
            'Content-Type': 'application/json',
          },
        body: jsonEncode({
          'product_id' :prodcutId,
        }),
          );
      if (response.statusCode == 200) {
        var responseBody =  jsonDecode(response.body);
        print(responseBody);
        setState(() {
          cartProducts.removeWhere((product)=>product["product_id"]==prodcutId);
          Get.snackbar(
            "",
            "",
            titleText: Center(
                child: Text(
                  "Product deleted".tr,
                  style: TextStyle(fontSize: 20),
                )),
            backgroundColor: Colors.greenAccent,
          );
        });
      }
    } catch (e) {
      print("$e");
    }
  }
  double calculateTotalPrice() {
    double total = 0;
    for (var product in cartProducts) {
      total += product['price'];
    }
    return total;
  }

  @override
  void initState() {
    getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  deleteCart();
                },
                icon: Icon(Icons.remove_shopping_cart))
          ],
          title: Text("Cart".tr,
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
        body: Card(
            color: Colors.white,
            shadowColor: const Color.fromARGB(255, 66, 252, 169),
            elevation: 6,
            child: Column(children: [
              SizedBox(height: 20),
              Text("Orders".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 20, 54, 64),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal)),
              const Text("_____________________________",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromARGB(255, 20, 54, 64),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal)),
              SizedBox(height: 40),
              Expanded(
                  flex: 3,
                  child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: cartProducts.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {},
                            child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: cartProducts[index]['image'] != null
                                        ? Image.memory(
                                      cartProducts[index]['image'],
                                      height: 125,
                                      fit: BoxFit.fitHeight,
                                    )
                                        : Image.asset(
                                      "images/prod.png",
                                      height: 125,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Center(
                                            child: Column(
                                              children: [

                                                Text(
                                                  "${cartProducts[index]['product_id']}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Color.fromARGB(
                                                          255, 48, 193, 152)),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    textDirection: isArabic()
                                                        ? TextDirection.ltr
                                                        : TextDirection.rtl,
                                                    children: [
                                                      Text(
                                                        "  ${cartProducts[index]['quantity']}  ",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .grey.shade800,
                                                        ),
                                                      ),
                                                      const Text(
                                                        ":",
                                                        style: TextStyle(
                                                            fontSize: 23,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 14,
                                                      ),
                                                      Text(
                                                        "Quantity".tr,
                                                        style: const TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    textDirection: isArabic()
                                                        ? TextDirection.ltr
                                                        : TextDirection.rtl,
                                                    children: [
                                                      Text(
                                                        "  ${cartProducts[index]['price']}\$  ",
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.red),
                                                      ),
                                                      const Text(
                                                        ":",
                                                        style: TextStyle(
                                                            fontSize: 23,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 14,
                                                      ),
                                                      Text(
                                                        "Price".tr,
                                                        style: const TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ),
                                          ))),
                                  IconButton(
                                      onPressed: () {
                                        deleteCartElement(cartProducts[index]['product_id']);
                                      },
                                      icon: Icon(
                                        Icons.delete_forever,
                                        size: 30,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                      " ____  ____  ____  ____  ____  ____ ")),
                              const SizedBox(height: 20)
                            ]));
                      })),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection:
                            isArabic() ? TextDirection.ltr : TextDirection.rtl,
                        children: [
                          Text(
                            " \$ ${calculateTotalPrice().toStringAsFixed(2)} ",
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
                            "Total Price".tr,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                          onPressed:cartProducts.isEmpty ? null:  () {
                            Get.to(PaymentMethod());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:cartProducts.isEmpty?
                              const Color.fromARGB(255, 150, 150, 150)
                                 : const Color.fromARGB(255, 20, 54, 64),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40)),
                          child: Text("Buy Now".tr,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: Color.fromARGB(255, 66, 252, 169),
                              ))),
                    )
                  ],
                ),
              )
            ])));
  }
}
