import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'FavoritesController.dart';
import 'ProductDetailsPage.dart';
import 'Stores.dart';
import 'main.dart';

class ProductsPage extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  final int storeId;

  const ProductsPage(
      {super.key, required this.products, required this.storeId});

  @override
  State<ProductsPage> createState() => _ProductsPage();
}

class _ProductsPage extends State<ProductsPage> {
  List<Map<String, dynamic>> products = [];

  Future<void> getProduct() async {
    try {
      var response = await get(
        Uri.parse(
            "http://127.0.0.1:8000/api/getstoreproducts/${widget.storeId}"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );
      print("Response Status: ${response.statusCode}");
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success'] == true) {
          setState(() {
            products =
                List<Map<String, dynamic>>.from(responseBody['products']);
          });
        } else {
          print(
              "Failed to fetch products: ${responseBody['message'] ?? 'Unknown error'}");
        }
      } else {
        print("HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  String? token = prefs!.getString("token");

  final FavoritesController favoritesController = Get.find();

  @override
  void initState() {
    super.initState();
    getProduct();
    favoritesController.loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.offAll(Stores());
            },
            icon: Icon(Icons.home)),
        title: Text("Products".tr,
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
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchCustom(products),
                );
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: products.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 284,
              ),
              itemCount: products.length,
              itemBuilder: (context, i) {
                String imagePath = products[i]["image"];
                String imageUrl = 'http://127.0.0.1:8000/$imagePath';
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsPage(productData: products[i]),
                    ));
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Obx(() => IconButton(
                                  onPressed: () {
                                    favoritesController
                                        .toggleFavorite(products[i]);
                                  },
                                  icon: Icon(
                                    favoritesController.isFavorite(products[i])
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: favoritesController
                                            .isFavorite(products[i])
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                )),
                          ],
                        ),
                        Image.network(
                          imageUrl,
                          height: 125,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print("Error loading image: $imageUrl");
                            return Image.asset(
                              'images/prod.png',
                              height: 120,
                              width: 160,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        SizedBox(height: 20,),
                        Text(products[i]["name"],textAlign:TextAlign.center ,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(255, 20, 54, 64))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Quantity : ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 20, 54, 64))),
                            Text(products[i]["quantity"].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 20, 54, 64))),
                          ],
                        ),
                        Text(products[i]["price"].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Color.fromARGB(255, 48, 193, 152))),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class SearchCustom extends SearchDelegate {
  final List<Map<String, dynamic>> products;

  SearchCustom(this.products);

  List? sortedItems;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.cleaning_services),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    sortedItems = products
        .where((element) =>
            element['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return sortedItems!.isEmpty
        ? const Center(child: Text('No products found'))
        : ListView.builder(
            itemCount: sortedItems!.length,
            itemBuilder: (context, index) {
              String imagePath = sortedItems![index]["image"];
              String imageUrl = 'http://127.0.0.1:8000/$imagePath';
              final product = sortedItems![index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsPage(productData: product),
                    ),
                  );
                },
                child: ListTile(
                  leading: Image.network(
                    imageUrl,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'images/prod.png',
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  title: Text(
                    product['name'],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    sortedItems = products
        .where((element) =>
        element['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return sortedItems!.isEmpty
        ? const Center(child: Text('No suggestions available'))
        : ListView.builder(
      itemCount: sortedItems!.length,
      itemBuilder: (context, index) {
        String imagePath = sortedItems![index]["image"];
        String imageUrl = 'http://127.0.0.1:8000/$imagePath';
        final product = sortedItems![index];
        return ListTile(
          leading: Image.network(
            imageUrl,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'images/prod.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              );
            },
          ),
          title: Text(
            product['name'],
            style: const TextStyle(fontSize: 16),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsPage(productData: product),
              ),
            );
          },
        );
      },
    );
  }
}
