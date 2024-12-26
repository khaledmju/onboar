// ignore_for_file: unused_import, file_names, use_key_in_widget_constructors, avoid_unnecessary_containers, non_constant_identifier_names, unused_local_variable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Cart.dart';
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
      bottomNavigationBar: GetBuilder<MyLocaleController>(builder: (controller) => CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: selectedIndex,
        items:  <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.home, size: 27),
              Text("Home".tr,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Icon(Icons.list, size: 27),
          //     Text("Orders",
          //         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          //   ],
          // ),
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.favorite, size: 27),
              Text("Favorite",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.shopping_cart, size: 27),
              Text("Cart".tr,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.settings, size: 27),
              Text("Setting".tr,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Icon(Icons.settings, size: 27),
          //     Text("setting ",
          //         style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          //   ],
          // ),
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
      ),),
      body: pages[selectedIndex], // Display the selected page
    );
  }
}

class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int currentPage = 0 ;
  final List stores = [
    {
      "image": "images/Nova_Cart.jpg",
      "title": "Apple Watch IP79",
      "subtitle": "Electronic Smart Watch",
    },
    {
      "image": "images/Nova_Cart.jpg",
      "title": "Apple Air pods Pro",
      "subtitle": "Smart , 6 hours straight use",
    },
    {
      "image": "images/Nova_Cart.jpg",
      "title": "Adidas Sneakers",
      "subtitle": "Sport comfortable Sneakers",
    },
    {
      "image": "images/Nova_Cart.jpg",
      "title": "Adidas Sneakers",
      "subtitle": "Sport comfortable Sneakers",
    },
    {
      "image": "images/Nova_Cart.jpg",
      "title": "Adidas Sneakers",
      "subtitle": "Sport comfortable Sneakers",
    },
  ];

  List pageviewImage = [
    "images/image_applications.jpg",
    "images/image_applications.jpg",
    "images/image_applications.jpg",
  ];

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
                  showSearch(context: context, delegate: SearchCustom());
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
        children:[
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: CarouselSlider(
              items:pageviewImage.map((e) =>Container(child: Image.asset(e,),) ,).toList(),
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
          const SizedBox(height: 20,),
        buildCarouselIndicator(),
        const SizedBox(height: 10,),
        Expanded(
          child: ListView.builder(
            itemCount: stores.length,
            itemBuilder: (context, index) {
              var Key = stores.elementAt(index);
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ProductsPage()));
                },
                child: Card(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          stores[index]['image'],
                          height: 125,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      "${stores[index]['title']}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          color: Color.fromARGB(
                                              255, 48, 193, 152)),
                                    ),
                                    Text(
                                      "${stores[index]['subtitle']}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          color:
                                              Color.fromARGB(255, 20, 54, 64)),
                                    ),
                                  ],
                                ),
                              ))),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
    ]
      ),

    );
  }
  buildCarouselIndicator(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(int i =0;i<pageviewImage.length;i++)
         Container(
           margin: const EdgeInsets.all(5),
           width:i==currentPage ?20: 5,
           height: i==currentPage ?10: 5,
           decoration: BoxDecoration(
             color:i==currentPage ? Colors.greenAccent:Colors.black,
             shape: BoxShape.circle,
         ),)
      ],
    );
  }
}

class SearchCustom extends SearchDelegate {
  List items = [
    {
      "image": "images/Nova_Cart.jpg",
      "title": "Apple Watch IP79",
      "subtitle": "Electronic Smart Watch",
      "price": "\$180",
    },
    {
      "image": "images/Nova_Cart.jpg",
      "title": "Apple Air pods Pro",
      "subtitle": "Smart , 6 hours straight use",
      "price": "\$399",
    },
    {
      "image": "images/Nova_Cart.jpg",
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
                query = query == "" ? items[index] : sortedItems?[index];
                showResults(context);
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
                              Text("${sortedItems![index]['title']}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 20, 54, 64),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20)),
                            ],
                          ))
                    ],
                  )));
        });
    // }
  }
}
