import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'FavoritesController.dart';
import 'ProductDetailsPage.dart';
import 'Stores.dart';

class ProductsPage extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  const ProductsPage({super.key, required this.products});


  @override
  State<ProductsPage> createState() => _ProductsPage();
}

class _ProductsPage extends State<ProductsPage> {
  final List<Map<String, dynamic>> products = [
    {
      "image": "images/logo.png",
      "title": "Apple Watch IP79",
      "subtitle": "Electronic Smart Watch",
      "quantity": "15",
      "price": "180\$",
    },
    {
      "image": "images/logo.png",
      "title": "Apple Air pods Pro",
      "subtitle": "Smart , 6 hours straight use",
      "quantity": "15",
      "price": "399\$",
    },
    {
      "image": "images/logo.png",
      "title": "Adidas Sneakers",
      "subtitle": "Sport comfortable Sneakers",
      "quantity": "15",
      "price": "157\$",
    },
  ];

  final FavoritesController favoritesController = Get.find();

  @override
  void initState() {
    super.initState();
    favoritesController.loadFavorites(); // Load saved favorites on app start
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.offAll(Stores());
        }, icon: Icon(Icons.home)),
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
          IconButton(onPressed: () {
            showSearch(context: context, delegate: SearchCustom());
          }, icon: Icon(Icons.search))
        ],
      ),
      body: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 277,
        ),
        itemCount: products.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetailsPage(productData: products[i]),
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
                          favoritesController.toggleFavorite(products[i]);
                        },
                        icon: Icon(
                          favoritesController.isFavorite(products[i])
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favoritesController.isFavorite(products[i])
                              ? Colors.red
                              : Colors.grey,
                        ),
                      )),
                    ],
                  ),
                  Image.asset(products[i]["image"],
                      height: 120, width: 1000, fit: BoxFit.cover),
                  Text(products[i]["title"],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color.fromARGB(255, 20, 54, 64))),
                  Text(products[i]["subtitle"],
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Quantity : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color.fromARGB(255, 20, 54, 64))),
                      Text(products[i]["quantity"],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color.fromARGB(255, 20, 54, 64))),
                    ],
                  ),
                  Text(products[i]["price"],
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
  List items = [
    {
      "image": "images/logo.png",
      "title": "Apple Watch IP79",
      "subtitle": "Electronic Smart Watch",
      "price": "\$180",
    },
    {
      "image": "images/logo.png",
      "title": "Apple Air pods Pro",
      "subtitle": "Smart , 6 hours straight use",
      "price": "\$399",
    },
    {
      "image": "images/logo.png",
      "title": "Adidas Sneakers",
      "subtitle": "Sport comfortable Sneakers",
      "price": "\$157",
    },
  ];

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
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    sortedItems = items
        .where((element) =>
        element['title'].toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: sortedItems!.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  productData: sortedItems![index],
                ),
              ),
            );
          },
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Image.asset(
                        sortedItems![index]["image"],
                        height: 50,
                        width: 70,
                        fit: BoxFit.fill,
                        alignment: Alignment.centerLeft,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "${sortedItems![index]['title']}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 20, 54, 64),
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
