import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'DriverDetails.dart';
import 'main.dart';

class Driver extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DriverState();
  }
}
class DriverState extends State<Driver> {
  List orders = [];
  String? token = prefs!.getString("token");

  // Fetch orders from backend
  Future<void> fetchOrders() async {
    try {
      var response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/getallorders"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {
          orders = data['orders'];
        });
      } else {
        print("Failed to load orders: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Fetch product name by product_id
  Future<String> fetchProductName(String productId) async {
    try {
      var response = await http.get(
        Uri.parse("http://127.0.0.1:8000/api/getproduct/$productId"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );

      print("Response for product $productId: ${response.body}"); // Debug

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // Access 'name' inside 'product' object
        return data['product']['name'] ?? "Unknown Product";
      } else {
        print("Failed to load product: ${response.statusCode}");
        return "Unknown Product";
      }
    } catch (e) {
      print("Error fetching product $productId: $e");
      return "Unknown Product";
    }
  }


  @override
  void initState() {
    super.initState();
    fetchOrders(); // Fetch orders when the screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              prefs!.setBool('showHome', false);
              prefs!.clear();
              Get.offAll(() => OnboardingPage());
            },
            icon: Icon(Icons.logout),
          ),
        ],
        title: Text(
          "Driver".tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 20, 54, 64),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 66, 252, 169),
        elevation: 4,
        shadowColor: Color.fromARGB(255, 48, 193, 152),
      ),
      body: Container(
        color: Colors.white,
        child: orders.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            var order = orders[index];
            var content = jsonDecode(order['content']);

            return InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DriverDetails(order: order),
                  ),
                );
              },
              child: Card(
                elevation: 6,
                shadowColor: Color.fromARGB(255, 66, 252, 169),
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Order number: ${order['id']}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 20, 54, 64),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: content.map<Widget>((product) {
                          return FutureBuilder<String>(
                            future: fetchProductName(
                                product['product_id'].toString()),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              var productName = snapshot.data ?? "Loading...";
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Name: $productName, ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(
                                          255, 20, 54, 64),
                                    ),
                                  ),
                                  Text(
                                    "Quantity: ${product['quantity']}, ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(
                                          255, 20, 54, 64),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Payment Method: ${order['paymentMethod']}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 20, 54, 64),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total Price: \$${order['totalPrice']}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 20, 54, 64),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Delivery Fee: \$${order['deliveryFee']}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 20, 54, 64),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () async {
                          setState(() {
                            // Mark the order as accepted (or any other action)
                          });
                        },
                        icon: Icon(
                          Icons.check_circle_outline_rounded,
                          size: 30,
                          color: Color.fromARGB(255, 66, 252, 169),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
