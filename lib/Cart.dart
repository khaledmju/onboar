import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:onboar/PaymentMethod.dart';

import 'ProductsPage.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CartState();
}

class CartState extends State<Cart> {
  bool isArabic() {
    return Get.locale?.languageCode == 'ar';
  }
  var totalPrice = 0;
  List cartProducts = [
    {
      "image": "images/logo.png",
      "title": "Apple Watch IP79",
      "subtitle": "Electronic Smart Watch",
      "quantity": "15",
      "price": "180",
    },
    {
      "image": "images/logo.png",
      "title": "Apple Air pods Pro",
      "subtitle": "Smart , 6 hours straight use",
      "quantity": "15",
      "price": "399",
    },
    {
      "image": "images/logo.png",
      "title": "Adidas Sneakers",
      "subtitle": "Sport comfortable Sneakers",
      "quantity": "15",
      "price": "157",
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
                          var productPrice = int.parse('${cartProducts[index]['price']}');
                          var productQuantity = int.parse('${cartProducts[index]['quantity']}');
                          var productTotalPrice = productPrice*productQuantity;
                          totalPrice = totalPrice*productTotalPrice;
                          var Key = cartProducts.elementAt(index);
                          return InkWell(
                              onTap: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) =>
                                //         const ProductsPage()));
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
                                                          "  ${cartProducts[index]['price']}\$  ",
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
                                                          " $productTotalPrice\$ ",
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
                                                ],
                                              ),
                                            ))),
                                    IconButton(onPressed: (){
                                      setState((){});
                                    }, icon: Icon(Icons.delete_forever , size: 30 , color: Colors.red,))
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
                  flex:1,
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        textDirection: isArabic()
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        children: [
                          Text(
                            " $totalPrice\$ ",
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
                    // Text("Total price".tr,
                    //     textAlign: TextAlign.center,
                    //     style: const TextStyle(
                    //         color: Color.fromARGB(255, 20, 54, 64),
                    //         fontSize: 22,
                    //         fontWeight: FontWeight.w500,
                    //         fontStyle: FontStyle.normal)),
                    SizedBox(height: 20),
                    Center(
                      // child: ElevatedButton(
                      //     onPressed: () {
                      //       setState((){
                      //         AwesomeDialog(
                      //           context: context,
                      //           dialogType: DialogType.question,
                      //           animType: AnimType.scale,
                      //           descTextStyle:
                      //           const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                      //           dialogBorderRadius: BorderRadius.circular(20),
                      //           desc: 'Are you sure you want to confirm this purchase?'.tr,
                      //           btnCancelText: "Cancel".tr,
                      //           btnOkText: "Confirm".tr,
                      //           btnOkColor: Color.fromARGB(255, 66, 252, 169),
                      //           btnCancelColor: Colors.red,
                      //           btnCancelOnPress: () {},
                      //           btnOkOnPress: () {
                      //             Get.snackbar(
                      //               padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                      //               backgroundColor: Colors.red,
                      //               "",
                      //               "",
                      //               icon: Icon(Icons.warning_amber,color: Colors.yellow,size: 30,),
                      //               duration: const Duration(milliseconds: 5000),
                      //               titleText: Center(
                      //                 child: Text("Your order has been sent. Awaiting confirmation from a driver.".tr,textAlign: TextAlign.center,style: TextStyle(
                      //                         color: Color.fromARGB(255, 20, 54, 64),fontSize: 16,
                      //                       )),
                      //               ),
                      //             );
                      //           },
                      //         ).show();
                      //       });
                      //     },
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor:
                      //         const Color.fromARGB(255, 20, 54, 64),
                      //         padding:
                      //         const EdgeInsets.symmetric(horizontal: 40)),
                      //     child: Text("Confirm Purchase".tr,
                      //         style: const TextStyle(
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.w400,
                      //           fontStyle: FontStyle.normal,
                      //           color: Color.fromARGB(255, 66, 252, 169),
                      //         ))),
                      child: ElevatedButton(onPressed: () {
                        Get.to(PaymentMethod());
                      },  style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color.fromARGB(255, 20, 54, 64),
                          padding:
                          const EdgeInsets.symmetric(horizontal: 40)),child: Text("Buy Now", style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        color: Color.fromARGB(255, 66, 252, 169),
                      ))),
                    )
                  ],),)
              ]))
    );
  }
}