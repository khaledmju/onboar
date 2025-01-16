import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:onboar/Stores.dart';

import 'main.dart';

class PaymentMethod extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PaymentMethodState();
  }
}

class PaymentMethodState extends State<PaymentMethod> {
  int selectedMethod = 0;
  String? token = prefs!.getString("token");

  Future<void> itemspurchased () async{
    try{
      String paymentmethod="";
      switch(selectedMethod){
        case 0:
          paymentmethod = "Cash";
          break;
          case 1:
          paymentmethod = "PayPal";
          break;
          case 2:
          paymentmethod = "Credit Card";
          break;
          case 3:
          paymentmethod = "Visa";
          break;
        default:
          paymentmethod ="Cash";
          break;
      }
      var response = await put(Uri.parse("http://127.0.0.1:8000/api/itemspurchased"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "deliveryFee":20,
          "paymentMethod":paymentmethod
        }),
      );
      if(response.statusCode == 200){
        Get.snackbar(
          "",
          "",
          titleText: Center(
              child: Text(
                "Confirm",
                style: TextStyle(fontSize: 20),
              )),
          backgroundColor: Colors.greenAccent,
          snackPosition: SnackPosition.BOTTOM,
        );
        print("$paymentmethod");
      }else{
        Get.snackbar(
          "",
          "",
          titleText: Center(
              child: Text(
                "Error",
                style: TextStyle(fontSize: 20),
              )),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }catch(e){
      print("Error : $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "Payment Method".tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Color.fromARGB(255, 20, 54, 64),
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        elevation: 4,
        shadowColor: const Color.fromARGB(255, 48, 193, 152),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              buildPaymentOption(0, "Cash", "images/cash.png"),
              const SizedBox(height: 20),
              buildPaymentOption(1, "PayPal", "images/paypal.png"),
              const SizedBox(height: 20),
              buildPaymentOption(2, "Credit Card", "images/creditcard.png"),
              const SizedBox(height: 20),
              buildPaymentOption(3, "Visa", "images/visa.png"),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.scale,
                      descTextStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                      dialogBorderRadius: BorderRadius.circular(20),
                      desc: 'Are you sure you want to confirm this purchase?'.tr,
                      btnCancelText: "Cancel".tr,
                      btnOkText: "Confirm".tr,
                      btnOkColor: const Color.fromARGB(255, 66, 252, 169),
                      btnCancelColor: Colors.red,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        itemspurchased();
                        Get.snackbar(
                          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                          backgroundColor: Colors.red,
                          "",
                          "",
                          icon: const Icon(
                            Icons.warning_amber,
                            color: Colors.yellow,
                            size: 30,
                          ),
                          duration: const Duration(milliseconds: 5000),
                          titleText: Center(
                            child: Text(
                              "Your order has been sent. Awaiting confirmation from a driver.".tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 20, 54, 64),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                        Get.offAll(()=>Stores());
                      },
                    ).show();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 20, 54, 64),
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                ),
                child: Text(
                  "Confirm Purchase".tr,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: Color.fromARGB(255, 66, 252, 169),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentOption(int value, String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = value;
        });
      },
      child: Container(
        width: 300,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedMethod == value ? Colors.red : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Radio<int>(
              value: value,
              groupValue: selectedMethod,
              onChanged: (int? newValue) {
                setState(() {
                  selectedMethod = newValue!;
                });
              },
            ),
            const SizedBox(width: 10),
            Image.asset(
              imagePath,
              width: 70,
              height: 70,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
