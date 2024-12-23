import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';

class Cart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CartState();
}

class CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart".tr,
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
      body: Center(
        child: Text("Cart".tr),
      ),
    );
  }
}
