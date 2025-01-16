import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class DriverDetails extends StatefulWidget {
  final Map<String, dynamic> order;

  DriverDetails({required this.order});

  @override
  State<DriverDetails> createState() => _DriverDetailsState();
}

class _DriverDetailsState extends State<DriverDetails> {
  String? token = prefs!.getString("token");
  // Fetch product name by product ID
  Future<String> fetchProductName(String productId) async {
    try {
      print("Fetching product for ID: $productId");
      var response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/getproduct/$productId"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data['product']['name'] ?? "Unknown Product";
      } else {
        print("Failed to fetch product. Status code: ${response.statusCode}");
        return "Unknown Product";
      }
    } catch (e) {
      print("Error fetching product: $e");
      return "Error fetching product";
    }
  }

  @override
  Widget build(BuildContext context) {
    var content = jsonDecode(widget.order['content']); // Parse product content.

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

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Image.asset(
                              "images/prod.png", // Replace with actual image logic if available.
                              height: 125,
                              fit: BoxFit.fitHeight,
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
                                  var productName =
                                      snapshot.data ?? "Loading...";
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.center,
                                        "Product Name: $productName",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 48, 193, 152),
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
                                        "Price: \$${product['price']}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey, height: 30),
                    ],
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
                        "Total Price: \$${widget.order['totalPrice']}",
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
                        "Delivery Fee: \$${widget.order['deliveryFee']}",
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
            ElevatedButton(
              onPressed: () {
                // Add any action for completing the order.
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 20, 54, 64),
                padding: const EdgeInsets.symmetric(horizontal: 40),
              ),
              child: const Text(
                "Complete Order",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 66, 252, 169),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
