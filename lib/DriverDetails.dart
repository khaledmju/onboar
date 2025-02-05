import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


import 'Driver.dart';
import 'main.dart';

class DriverDetails extends StatefulWidget {
  final Map<String, dynamic> order;

  DriverDetails({required this.order});

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  String? token = prefs!.getString("token");

  Future<String> fetchProductName(String productId) async {
    try {
      var response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/getproduct/$productId"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['product']['name'] ?? "Unknown Product";
      } else {
        return "Unknown Product";
      }
    } catch (e) {
      return "Error fetching product";
    }
  }

  Future<Uint8List?> fetchImage(String productId) async {
    try {
      var response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/getproductimage/$productId"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching image: $e");
      return null;
    }
  }
  @override
  void initState() {
    print(token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var content = jsonDecode(widget.order['content']);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: const TextStyle(
            color: Color.fromARGB(255, 20, 54, 64),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        elevation: 4,
        shadowColor: const Color.fromARGB(255, 48, 193, 152),
      ),
      body: Card(
        color: Colors.white,
        shadowColor: const Color.fromARGB(255, 66, 252, 169),
        elevation: 6,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              "Order #${widget.order['id']}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 20, 54, 64),
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Text(
              "_____________________________",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 20, 54, 64),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: content.length,
                itemBuilder: (context, index) {
                  var product = content[index];
                  return FutureBuilder<Uint8List?>(
                    future: fetchImage(product['product_id'].toString()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Loading Product...",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 48, 193, 152),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text("Error fetching image"),
                            ),
                          ],
                        );
                      } else if (snapshot.hasData && snapshot.data != null) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.memory(
                                snapshot.data!,
                                height: 125,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: FutureBuilder<String>(
                                  future: fetchProductName(
                                      product['product_id'].toString()),
                                  builder: (context, snapshot) {
                                    var productName = snapshot.data ?? "Loading...";
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          textAlign: TextAlign.center,
                                          "Product Name: $productName",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 48, 193, 152),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Quantity: ${product['quantity']}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Price: ${product['price']}\$",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.red,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                                " ____  ____  ____  ____  ____  ____ ")),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        // Fallback case
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                "images/prod.png", // Fallback image
                                height: 125,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text("No Image Available"),
                            ),
                          ],
                        );
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total Price: ${widget.order['totalPrice']}\$",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Delivery Fee: ${widget.order['deliveryFee']}\$",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => Driver());
                    print("Delivery confirmed for Order #${widget.order['id']}");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Confirm button color
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  child: const Text(
                    "Confirm Delivery",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {

                    print("Delivery refused for Order #${widget.order['id']}");
                    Get.offAll(() => Driver());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Refuse button color
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  child: const Text(
                    "Refuse Delivery",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}