import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';

import 'ProductsPage.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CartState();
}

class CartState extends State<Cart> {
  bool isArabic() {
    return Get.locale?.languageCode == 'ar';
  }
  List cartProducts = [
    {
      "image": "images/logo.png",
      "title": "Apple Watch IP79",
      "subtitle": "Electronic Smart Watch",
      "quantity": "15",
      "price": "\$180",
    },
    {
      "image": "images/logo.png",
      "title": "Apple Air pods Pro",
      "subtitle": "Smart , 6 hours straight use",
      "quantity": "15",
      "price": "\$399",
    },
    {
      "image": "images/logo.png",
      "title": "Adidas Sneakers",
      "subtitle": "Sport comfortable Sneakers",
      "quantity": "15",
      "price": "\$157",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
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
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          var Key = cartProducts.elementAt(index);
                          return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductsPage()));
                              },
                              child: Column(children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Image.asset(
                                        cartProducts[index]['image'],
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
                                                    "${cartProducts[index]['title']}",
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
                                                    padding: const EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      textDirection: isArabic()
                                                          ? TextDirection.ltr
                                                          : TextDirection.rtl,
                                                      children: [
                                                        Text(
                                                          "  ${cartProducts[index]['quantity']}  ",
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
                                                  const SizedBox(height: 10),
                                                  Container(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      textDirection: isArabic()
                                                          ? TextDirection.ltr
                                                          : TextDirection.rtl,
                                                      children: [
                                                        Text(
                                                          "  ${cartProducts[index]['price']}  ",
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
                                            ))),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                        " ____  ____  ____  ____  ____  ____ ")),
                                SizedBox(height: 10)
                              ]));
                        }))
              ]))
    );
  }
}
