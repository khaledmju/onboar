import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PaymentMethodState();
  }
}

class PaymentMethodState extends State<PaymentMethod> {
  int selectedMethod = 0; // to know selected method

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
