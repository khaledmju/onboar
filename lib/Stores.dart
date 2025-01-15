import 'dart:convert';
import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:onboar/main.dart';
import 'Cart.dart';
import 'FavoritesController.dart';
import 'FavoritesPage.dart';
import 'ProductsPage.dart';
import 'Settings.dart';
import 'local/local_controller.dart';

class Stores extends StatefulWidget {
  const Stores({super.key});

  @override
  State<Stores> createState() => StoresState();
}

class StoresState extends State<Stores> {
  late final List<Widget> pages;
  int selectedIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    pages = [
      HomeContent(),
      FavoritesPage(),
      Cart(),
      const Settings(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GetBuilder<MyLocaleController>(
        builder: (controller) => CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: selectedIndex,
          items: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.home, size: 27),
                Text("Home".tr,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite, size: 27),
                Text("Favorite".tr,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.shopping_cart, size: 27),
                Text("Cart".tr,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.settings, size: 27),
                Text("Setting".tr,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
          ],
          color: const Color.fromARGB(255, 66, 252, 169),
          buttonBackgroundColor: const Color.fromARGB(255, 66, 252, 169),
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          backgroundColor: Colors.transparent,
          onTap: (val) {
            setState(() {
              selectedIndex = val;
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
      body: pages[selectedIndex],
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

final FavoritesController favoritesController = Get.find();

class _HomeContentState extends State<HomeContent> {
  int currentPage = 0;
  String? token = prefs!.getString("token");
  final List stores = [];
  final Map<int, Uint8List> storeImages = {};
  List pageviewImage = [
    "images/discount.jpg",
    "images/discount2.jpg",
    "images/discount3.jpg",
    "images/discount4.jpg",
  ];

  bool loading = false;
  Future<void> getStore() async {
    try {
      var response = await get(
        Uri.parse("http://127.0.0.1:8000/api/getallstores"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );
      print("Response Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        setState(() {
          stores.addAll(responseBody);
        });
        for (var store in stores) {
          int storeId = store["id"];
          Uint8List? imageBytes = await getStoreImage(storeId);
          if (imageBytes != null) {
            setState(() {
              storeImages[storeId] = imageBytes;
            });
          }
        }
      } else {
        print("Failed to load stores.");
      }
    } catch (e) {
      print("Error fetching stores: $e");
    }
  }
  Future<Uint8List?> getStoreImage(int storeId) async {
    try {
      var response = await get(
        Uri.parse("http://127.0.0.1:8000/api/getstoreimage/$storeId"),
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return response.bodyBytes; // Return raw image bytes
      } else {
        print(
            "Failed to fetch image for store $storeId: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching image for store $storeId: $e");
    }
    return null;
  }

  @override
  void initState() {
    favoritesController.loadFavorites();
    getStore();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 66, 252, 169),
        actions: [
          const SizedBox(width: 20),
          Container(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: InkWell(
                onTap: () {
                  showSearch(
                    context: context,
                    delegate: SearchCustom(stores,storeImages), // Pass stores here
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Search for Stores..".tr,
                      style: const TextStyle(fontSize: 17),
                    ),
                    const Icon(Icons.search),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 50,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: CarouselSlider(
              items: pageviewImage
                  .map(
                    (e) => Container(
                      child: Image.asset(
                        e,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 150,
                initialPage: 0,
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeFactor: 0.1,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPage = index;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildCarouselIndicator(),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: stores.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: stores.length,
                    itemBuilder: (context, index) {
                      int storeId = stores[index]["id"];
                      Uint8List? imageBytes = storeImages[storeId];
                      return InkWell(
                        onTap: () {
                          Get.offAll(ProductsPage(
                            products: [],
                            storeId: storeId,
                          ));
                        },
                        child: Card(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: imageBytes != null
                                    ? Image.memory(
                                        imageBytes,
                                        height: 125,
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'images/prod.png',
                                            height: 125,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        'images/prod.png',
                                        height: 125,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: EdgeInsets.only(top: 12, bottom: 12),
                                  alignment: Alignment.centerLeft,
                                  child: Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          "${stores[index]["name"]}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.normal,
                                              color: Color.fromARGB(
                                                  255, 48, 193, 152)),
                                        ),
                                        Text(
                                          "${stores[index]["description"]}",
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            color:
                                                Color.fromARGB(255, 20, 54, 64),
                                          ),
                                        ),
                                      ],
                                    ),
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
        ],
      ),
    );
  }

  buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < pageviewImage.length; i++)
          Container(
            padding: const EdgeInsets.all(5),
            width: i == currentPage ? 20 : 5,
            height: i == currentPage ? 10 : 5,
            decoration: BoxDecoration(
              color: i == currentPage ? Colors.greenAccent : Colors.black,
              shape: BoxShape.circle,
            ),
          )
      ],
    );
  }
}
class SearchCustom extends SearchDelegate {
  final List stores;
  final Map<int, Uint8List> storeImages;

  SearchCustom(this.stores, this.storeImages);

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
    sortedItems = stores
        .where((element) =>
        element["name"].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: sortedItems!.length,
      itemBuilder: (context, index) {
        int storeId = sortedItems![index]["id"];
        Uint8List? imageBytes = storeImages[storeId]; // Fetch from storeImages map

        return InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsPage(
                    products: [sortedItems![index]],
                    storeId: storeId,
                  ),
                ));
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
    sortedItems = stores
        .where((element) =>
        element["name"].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: sortedItems!.length,
      itemBuilder: (context, index) {
        int storeId = sortedItems![index]["id"];
        Uint8List? imageBytes = storeImages[storeId]; // Fetch from storeImages map

        return ListTile(
          leading: imageBytes != null
              ? Image.memory(
            imageBytes,
            height: 60,
            width: 60,
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'images/storee.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              );
            },
          )
              : Image.asset(
            'images/storee.png',
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
          title: Center(
            child: Text(
              sortedItems![index]["name"],
              style: const TextStyle(fontSize: 20),
            ),
          ),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsPage(
                    products: [sortedItems![index]],
                    storeId: storeId,
                  ),
                ));
          },
        );
      },
    );
  }
}
