import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Map<int, Uint8List> productImages = {};

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
          List<Map<String, dynamic>> fetchedProducts =
              List<Map<String, dynamic>>.from(responseBody['products']);

          setState(() {
            products = fetchedProducts;
          });

          // Fetch product images
          for (var product in products) {
            int productId = product["id"];
            Uint8List? imageBytes = await fetchProductImage(productId);
            if (imageBytes != null) {
              setState(() {
                productImages[productId] = imageBytes;
              });
            }
          }
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

  Future<Uint8List?> fetchProductImage(int productId) async {
    try {
      var response = await get(
        Uri.parse("http://127.0.0.1:8000/api/getproductimage/$productId"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return response.bodyBytes; // Return raw image bytes
      } else {
        print(
            "Failed to fetch image for product $productId: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching image for product $productId: $e");
    }
    return null;
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
                    delegate: SearchCustom(products, productImages),
                  );
                },
                icon: Icon(Icons.search))
          ],
        ),
        body: products.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 310,
                ),
                itemCount: products.length,
                itemBuilder: (context, i) {
                  int productId = products[i]["id"];
                  Uint8List? imageBytes = productImages[productId];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          productData: products[i],
                          productImage: productImages[products[i]["id"]],
                        ),
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
                          Expanded(
                            child: imageBytes != null
                                ? Image.memory(
                                    imageBytes,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    'images/prod.png',
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                         const SizedBox(
                            height: 20,
                          ),
                          Text(products[i]["name"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 20, 54, 64))),
                          const SizedBox(
                            height: 7,
                          ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Quantity : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 20, 54, 64))),
                              Text((products[i]["quantity"] <1 ?0: products[i]["quantity"]).toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 20, 54, 64))),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(products[i]["price"].toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 48, 193, 152))),
                              Text(
                                "\$",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],),
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
  final Map<int, Uint8List> productImages;

  SearchCustom(this.products, this.productImages);

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

    return ListView.builder(
      itemCount: sortedItems!.length,
      itemBuilder: (context, index) {
        int productId = sortedItems![index]["id"];
        Uint8List? imageBytes = productImages[productId];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  productData: sortedItems![index],
                  productImage: productImages[sortedItems![index]["id"]],
                ),
              ),
            );
          },
          child: Container(
            color: Colors.white,
            child: ListTile(
              leading: imageBytes != null
                  ? Image.memory(
                      imageBytes,
                      height: 60,
                      width: 60,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'images/prod.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'images/prod.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
              title: Text(
                textAlign: TextAlign.center,
                sortedItems![index]["name"],
                style: const TextStyle(fontSize: 16),
              ),
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

    return ListView.builder(
      itemCount: sortedItems!.length,
      itemBuilder: (context, index) {
        int productId = sortedItems![index]["id"];
        Uint8List? imageBytes =
            productImages[productId]; // Fetch from storeImages map

        return Container(
          height: 100,
          child: Card(
            child: ListTile(
              leading: imageBytes != null
                  ? Image.memory(
                      imageBytes,
                      height: 60,
                      width: 60,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'images/prod.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'images/prod.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
              title: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  sortedItems![index]["name"],
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(
                        productData: products[index],
                        productImage: productImages[sortedItems![index]["id"]],
                      ),
                    ));
              },
            ),
          ),
        );
      },
    );
  }
}
